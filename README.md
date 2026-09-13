# homebrew-xenia-talk

Homebrew tap for [Xenia Talk](https://github.com/Krateos-BV/talk-desktop), a desktop
client based on Nextcloud Talk Desktop.

## Install

```sh
brew tap Krateos-BV/xenia-talk
brew install --cask xenia-talk
```

Or in one step:

```sh
brew install --cask krateos-bv/xenia-talk/xenia-talk
```

## Unsigned builds

Releases are not signed or notarized by Apple. macOS Gatekeeper blocks the app
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

## Licence

Xenia Talk is distributed under the AGPLv3. It is not affiliated with, or endorsed
by, Nextcloud GmbH.
