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

All three artifacts are made by
[`build.yml`](.github/workflows/build.yml), which is a matrix over the platforms
rather than three workflows: a release of Wargus is its installer, its `dmg` and
its AppImage together, and there is no revision of it for which only one of them
is wanted. A push to `master`, a tag or a manual "Run workflow" builds all three,
and so does [`engine.yml`](.github/workflows/engine.yml), which runs daily and
starts that build when the engine has moved since the artifacts went up. A pull
request is built so that it can be reviewed, but publishes nothing, and it is the
only build a branch gets: `master` and version tags are the refs that publish, so
a branch with a pull request is not built twice. Each platform uploads what it
built to the release for the revision it ran for, creating that release if none of
them has yet, and pushes to `master` upload to the [master-builds
release](https://github.com/Wargus/wargus/releases/tag/master-builds) instead.

The Linux job runs `tools/ci-build.sh`, which takes one argument, the
platform being built for, and does that platform's whole artifact. The AppImage
can therefore be built locally the same way, which is what the job does:

```sh
git clone --recursive https://github.com/Wargus/stratagus ../stratagus
tools/ci-build.sh linux   # and macos or windows, where the tools are
```

It writes the artifact to `release-assets/`, and takes the engine from
`../stratagus` unless `ENGINE_SRC` says otherwise.

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
