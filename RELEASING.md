# Releasing Wargus

Wargus is released in lockstep with the Stratagus engine: a release of version
`X.Y.Z` is tagged `vX.Y.Z` here and in
[`Wargus/stratagus`](https://github.com/Wargus/stratagus), and the workflows
here build against the engine tag with the matching name, falling back to the
engine `master` branch when there is no such tag. Tag the engine first, so that
the artifacts built here are built against the engine that is being released.
See `RELEASING.md` in the engine repository for the engine part of the release,
including its documentation and changelog.

## Release artifacts

| artifact | workflow |
| --- | --- |
| Windows installer | [`windows.yml`](.github/workflows/windows.yml) |
| macOS `dmg` | [`macos.yml`](.github/workflows/macos.yml) |
| Linux AppImage | [`ubuntu.yml`](.github/workflows/ubuntu.yml) |

A push to `master`, a tag, a manual "Run workflow", or a push to the engine
`master` (which announces it with the "Downstream builds" workflow of
[`Wargus/stratagus`](https://github.com/Wargus/stratagus)) makes all three
build, and
the AppVeyor-era packaging and the Launchpad recipes are gone with the CI that
ran them. Each of the three workflows uploads its artifact to the release for
the tag it ran for, creating that release if none of them has yet, and pushes to
`master` upload to the [master-builds
release](https://github.com/Wargus/wargus/releases/tag/master-builds) instead.

The AppImage can also be built locally, which is what the Linux workflow runs:

```sh
git clone --recursive https://github.com/Wargus/stratagus ../stratagus
tools/build_appimage.sh ../stratagus
```

## Tagging a release

`X.Y.Z` below is the version being released, and `vX.Y.Z` the tag.

1. Increase the version in:

   | file | |
   | --- | --- |
   | `scripts/stratagus.lua` | `wargus.Version`, which the game shows in the UI |
   | `wargus.nsi` | `VERSION` of the installer, and its `COPYRIGHT` years |
   | `wargus.rc` | `VERSION`, and `VIVERSION` of the same version with commas |
   | `mac/Info.plist` | `CFBundleShortVersionString` of the app bundle |

2. Write the release notes in `doc/changelog`.

3. Add the changelog entry for the new version with `dch -v X.Y.Z-1`, close it
   with `dch -r`, and move the years in `debian/copyright` if needed.

4. Commit and merge to `master`: `git commit -a -m "Release version X.Y.Z"`.

5. Once the engine has been tagged `vX.Y.Z`, tag and push here. The three
   workflows then build the artifacts and put them on the release.

   ```sh
   git tag vX.Y.Z
   git push origin master --tags
   ```

   With the artifacts up, write the notes for the release, e.g. with
   `gh release edit vX.Y.Z --verify-tag --notes-file notes.md`.

6. Update the download links for the stable versions in the website
   repository.
