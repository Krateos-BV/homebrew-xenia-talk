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

Or in one step:

```sh
brew install --cask krateos-bv/xenia-talk/xenia-talk
brew install --cask krateos-bv/xenia-talk/xenia-files
```

## Unsigned builds (Xenia Talk)

Xenia Talk releases in this tap are not signed or notarized by Apple. macOS Gatekeeper blocks the app
until the quarantine attribute is cleared:

```sh
xattr -d com.apple.quarantine "/Applications/Xenia Talk.app"
```

The cask prints this as a caveat on install.

## Updating the cask for a new release

The `sha256` in `Casks/xenia-talk.rb` is tied to one release artifact and must be
bumped every release — a stale checksum is the most common way a cask breaks.

```sh
VERSION=x.y.z
curl -fL -o /tmp/xenia-talk.zip \
  "https://github.com/Krateos-BV/talk-desktop/releases/download/v${VERSION}/Xenia.Talk-macos-universal.zip"
shasum -a 256 /tmp/xenia-talk.zip
```

Update `version` and `sha256`, then verify:

```sh
brew style Casks/xenia-talk.rb
brew audit --cask --online krateos-bv/xenia-talk/xenia-talk
```

### Xenia Files

Xenia Files ships a signed, notarised and stapled DMG, so no quarantine step is
needed. The macOS build is arm64 only. Take the checksum from the release's
`SHA256SUMS` and cross-check it against the download:

```sh
VERSION=yy.m.d
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
