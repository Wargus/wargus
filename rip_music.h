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

    rip_music.h - rip audio CD
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

#ifndef _RIP_MUSIC_H_
#define _RIP_MUSIC_H_

#if __has_include(<filesystem>)
#include <filesystem>
namespace fs = std::filesystem;
#elif __has_include(<experimental/filesystem>)
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;
#else
error "Missing the <filesystem> header."
#endif

#include <array>
#include <string>

static const std::array<std::string, 17> MusicNames = {
	"Human Battle 1",
	"Human Battle 2",
	"Human Battle 3",
	"Human Battle 4",
	"Human Battle 5",
	"Human Briefing",
	"Human Victory",
	"Human Defeat",
	"Orc Battle 1",
	"Orc Battle 2",
	"Orc Battle 3",
	"Orc Battle 4",
	"Orc Battle 5",
	"Orc Briefing",
	"Orc Victory",
	"Orc Defeat",
    "I'm a Medieval Man"
};

static const std::array<std::string, 2> BNEMusicNames = {
	"Human Battle 6",
    "Orc Battle 6"
};

int RipMusic(int expansion_cd, const std::filesystem::path &data_dir, const std::filesystem::path &dest_dir);

#endif
