# About Wargus

<img src="./ico_alt.svg" width="200" align="right" />

Wargus is a Warcraft 2 mod that allows you to play Warcraft 2 with the Stratagus engine. The game looks and sounds exactly like Warcraft 2. The gameplay is very close to Warcraft 2's gameplay, with slight enhancements more similar to Starcraft. You can find more details on Wargus at [stratagus.com](https://stratagus.com).

### Downloads

Every release of Wargus comes with a Windows installer, a macOS `dmg` and a
Linux AppImage:

- [Latest stable release](https://github.com/Wargus/wargus/releases/latest)
- [Latest unstable build](https://github.com/Wargus/wargus/releases/tag/master-builds) — rebuilt for every push to `master`, so it is the newest development build rather than a tested release

Older releases are in the [release list](https://github.com/Wargus/wargus/releases), and [stratagus.com](https://stratagus.com) explains how to install and where to get the game data from.

### Extracting data for macOS

In order to play Wargus on macOS you first need to extract the game data from your Warcraft 2 installer. The built-in extractor tool is currently not working correctly, but you can use
[this third-party script](https://github.com/shinra-electric/Stratagus-Data-Extractor-Script) for now. <br>

Run the script in the same folder as your game data and the Wargus app. 

It will not be needed in the future when all the bugs are fixed. 

### Build status:
- Windows: ![Build Status](https://github.com/Wargus/wargus/actions/workflows/windows.yml/badge.svg)
- Linux: ![Build Status](https://github.com/Wargus/wargus/actions/workflows/ubuntu.yml/badge.svg)
- macOS: ![Build Status](https://github.com/Wargus/wargus/actions/workflows/macos.yml/badge.svg)

The Windows workflow builds the installer, the Linux workflow the AppImage and
the macOS workflow the `dmg`; pushing a version tag creates the release with
those artifacts, and pushes to `master` update the `master-builds` release.
`RELEASING.md` describes how a release is made.

### Join the community
[![Join the chat at https://gitter.im/Wargus](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Wargus?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Discord](https://img.shields.io/discord/780082494447288340?style=flat-square&logo=discord&label=discord)](https://discord.gg/dQGxaw3QfB)

### Translations:
To help with translations, visit these pages:
* Engine strings: https://poeditor.com/join/project?hash=BVo8MAZuys
* Game strings: https://poeditor.com/join/project?hash=7myZPTmcqq
