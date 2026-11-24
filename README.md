# homebrew-xenia-talk

Homebrew tap for the Xenia desktop clients:

- [Xenia Talk](https://github.com/Krateos-BV/talk-desktop), based on Nextcloud Talk Desktop (cask `xenia-talk`)
- [Xenia Files](https://github.com/Krateos-BV/files-desktop), based on the Nextcloud desktop sync client (cask `xenia-files`, Apple silicon only)

## Install

```sh
brew tap Krateos-BV/xenia-talk
brew trust krateos-bv/xenia-talk
brew install --cask xenia-talk
```

Current Homebrew refuses to load casks from a third-party tap until you trust it
(`brew trust`), once per tap.

Or in one step (the tap still has to be trusted first):

```sh
brew trust krateos-bv/xenia-talk
brew install --cask krateos-bv/xenia-talk/xenia-talk
brew install --cask krateos-bv/xenia-talk/xenia-files
```

### If the app is already installed from the DMG

If Xenia Talk or Xenia Files is already in `/Applications` from a manual DMG
install, the first `brew install` stops with "It seems there is already an App
at ...". Let Homebrew take over the existing app instead.

When the installed version matches the cask version, adopt it:

```sh
brew install --cask --adopt krateos-bv/xenia-talk/xenia-files
```

Otherwise use `--force`. It replaces only the app bundle. Settings, login and
synced files in `~/Library` stay in place:

```sh
brew install --cask --force krateos-bv/xenia-talk/xenia-files
```

Use `xenia-talk` in place of `xenia-files` for Xenia Talk.

## Updating the cask for a new release

The `sha256` in each cask is tied to one release artifact and must be bumped
every release. A stale checksum is the most common way a cask breaks.

### Xenia Talk

Xenia Talk ships a signed and notarised universal build, so no quarantine step
is needed. Take the checksum from the release's `SHA256SUMS`, cross-check it
against the download and check the app inside is stapled:

```sh
VERSION=yy.m.d.n
curl -fL -o /tmp/xenia-talk.zip \
  "https://github.com/Krateos-BV/talk-desktop/releases/download/v${VERSION}/Xenia.Talk-macos-universal.zip"
shasum -a 256 /tmp/xenia-talk.zip
ditto -x -k /tmp/xenia-talk.zip /tmp/xenia-talk
xcrun stapler validate "/tmp/xenia-talk/Xenia Talk.app"
brew style Casks/xenia-talk.rb
brew audit --cask --online krateos-bv/xenia-talk/xenia-talk
```

### Xenia Files

Xenia Files ships a signed, notarised and stapled DMG, so no quarantine step is
needed. The macOS build is arm64 only. Release tags have three or four parts
(`v26.11.19`, `v26.11.11.2`); set `VERSION` to the tag without the leading `v`. Take the checksum from the
release's `SHA256SUMS` and cross-check it against the download:

```sh
VERSION=yy.m.d[.n]
curl -fL -o /tmp/xenia-files.dmg \
  "https://github.com/Krateos-BV/files-desktop/releases/download/v${VERSION}/Xenia-Files-v${VERSION}-macos-arm64-signed.dmg"
shasum -a 256 /tmp/xenia-files.dmg
xcrun stapler validate /tmp/xenia-files.dmg
brew style Casks/xenia-files.rb
brew audit --cask --online krateos-bv/xenia-talk/xenia-files
```

## Licence

Xenia Talk is distributed under the AGPLv3 and Xenia Files under the GPLv2 or later.
Neither is affiliated with, or endorsed by, Nextcloud GmbH.
