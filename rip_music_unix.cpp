/*
       _________ __                 __
      /   _____//  |_____________ _/  |______     ____  __ __  ______
      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
             \/                  \/          \//_____/            \/
  ______________________                           ______________________
                        T H E   W A R   B E G I N S
         Stratagus - A free fantasy real time strategy game engine

    rip_music_unix.c - rip audio CD on Unix with cdparanoia
    Copyright (C) 2011  Pali Rohár <pali.rohar@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <libgen.h>
#include <spawn.h>

#if defined(__linux__)
#	include <mntent.h>
#elif defined(__FreeBSD__)
#	include <sys/param.h>
#	include <sys/mount.h>
#elif defined(__APPLE__)
#       define __dev_t dev_t
#       define __ino_t ino_t
#endif

#include "rip_music.h"

#include <iostream>
namespace fs = std::filesystem;


static fs::path find_mnt_dir(const fs::path &dir)
{
    fs::path out;
    fs::path save_cwd;
    fs::path last_cwd;
    fs::path cwd;
    fs::path mnt_dir;
    std::error_code error_code;

	struct stat st;
	__dev_t last_dev;
	__ino_t last_ino;

    save_cwd = std::filesystem::current_path(error_code);
    if (error_code) {
        std::cerr << "Error: Cannot store working directory: " << error_code.message() << std::endl;
        return fs::path();
    }

    if (!fs::is_directory(dir)) {
        std::cerr << "Not a directory" << std::endl;
        return fs::path();
	}

    fs::current_path(dir, error_code);
    if (error_code) {
        std::cerr << "Error: Cannot change path to " << dir << ": " << error_code.message() << std::endl;
    }

    last_cwd = fs::current_path(error_code);

    if (error_code) {

        std::cerr <<  "Error: Cannot get working directory: " << dir << ": " << error_code.message() << std::endl;
        error_code.clear();
        fs::current_path(save_cwd, error_code);

        if (error_code) {
            std::cerr << "Error: Cannot restore working directory: " << error_code.message() << std::endl;
        }

        return fs::path();
    }

    if (stat(last_cwd.c_str(), &st) != 0) {
        std::cerr << "Error: Cannot stat " << cwd << " " << strerror(errno) << std::endl;
        return fs::path();
	}
	last_dev = st.st_dev;
	last_ino = st.st_ino;

    while (1) {
        fs::current_path("..", error_code);
        if (error_code) {

            std::cerr << "Error: Cannot change working directory: " << error_code.message() << std::endl;
            error_code.clear();
			break;

		}
        cwd = fs::current_path(error_code);

        if (error_code) {
            std::cerr << "Error: Cannot get working directory: " << error_code.message() << std::endl;
            error_code.clear();
			break;
		}

        if (stat(cwd.c_str(), &st) != 0) {
            std::cerr << "Error: Cannot stat " << cwd << " " << strerror(errno) << std::endl;
            break;
		}

        if (last_dev != st.st_dev || fs::equivalent(last_cwd, cwd)) {
            mnt_dir = last_cwd;
			break;
		}

        if (fs::equivalent(cwd, "/")) {

            mnt_dir = fs::path("/");
			break;

		}

		last_dev = st.st_dev;
		last_ino = st.st_ino;
        last_cwd = cwd;
	}

    fs::current_path(save_cwd, error_code);
    if (error_code) {
        std::cerr << "Error: Cannot restore working directory: " << error_code.message() << std::endl;
    }

	return mnt_dir;

}

static fs::path find_dev(const fs::path &mnt_dir)
{

#if defined(__linux__)
    struct mntent *mnt;
    fs::path dev{};
    FILE *file;

	file = setmntent("/proc/self/mounts", "r");

    if (! file) {
        std::cerr <<  "Error: Cannot open file /proc/self/mounts: " << strerror(errno) << std::endl;
        return fs::path();

	}

    while ((mnt = getmntent(file))) {
        std::string comp = mnt->mnt_dir;

        if (comp == mnt_dir) {
            dev = fs::path{comp};
			break;
		}
	}

	endmntent(file);

	return dev;
#elif defined(__FreeBSD__)
	struct statfs sfs;

    if (statfs(mnt_dir.c_str(), &sfs) != 0) {

		fprintf(stderr, "Error: Cannot get mounted device: %s\n", strerror(errno));
		return NULL;

	}

	return strdup(sfs.f_mntfromname);
#else
    return fs::path {};
#endif

}

static int spawnvp(const std::string &file, char *const argv[])
{
	int status;
    pid_t pid;

    if (posix_spawnp(&pid, file.c_str(), nullptr, nullptr, argv, nullptr)) {
        std::cerr << "Could not spawn process: " << file << std::endl;
    }

    if (waitpid(pid, &status, 0) == pid) {
		return WEXITSTATUS(status);
    } else {
		return -1;
    }
}

std::unique_ptr<char []> make_unique_from_string(const std::string &in)
{
    std::unique_ptr<char []>out = std::make_unique<char []>(in.length() + 1);
    in.copy(out.get(), in.length());
    out[in.length()] = '\0';
    return out;
}

int RipMusic(int expansion_cd, const fs::path &data_dir, const fs::path &dest_dir)
{
    //FIXME: clean this up more later.
    fs::path dev;
	int count = 0;
	int i;

    if (!fs::exists(data_dir)) {
        std::cerr << "Directory does not exist! " << data_dir << std::endl;
		return 1;
	}

    auto mnt_dir = find_mnt_dir(data_dir);

    if (mnt_dir == fs::path()) {
        std::cerr << "Error: Cannot find mount dir" << std::endl;
		return 1;
	}

	dev = find_dev(mnt_dir);

    if (dev == fs::path()) {
        std::cerr << "Error: Cannot find device for mount dir " << mnt_dir << std::endl;
		return 1;

	}

    std::cout << "Found CD-ROM device: " << dev << std::endl;
    std::flush(std::cout);
    auto dev_string = make_unique_from_string(dev.string());
    char *args[6] = { (char *)"cdparanoia", (char *)"-d", dev_string.get(), (char *)"-v", (char *)"-Q", NULL };

    if (spawnvp(args[0], args) != 0) {
		return 1;
	}

    for (i = 0; !MusicNames[i].empty(); ++i) {
        std::string num;
        fs::path file{dest_dir};

        if (! expansion_cd && ! MusicNames[i + 1].empty()) {
			break;
        }
        num = std::to_string(i + 2);

        file /= MusicNames[i];
        file.replace_extension(".wav");
        auto num_string = make_unique_from_string(num);
        auto file_string = make_unique_from_string(file.string());
        args[3] = num_string.get();
        args[4] = file_string.get();

        if (spawnvp(args[0], args) == 0) {
			++count;
        }

	}

    if (count == 0) {
		return 1;
    } else {
		return 0;
    }

}
