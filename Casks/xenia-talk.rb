cask "xenia-talk" do
  version "2026.9.10"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/Krateos-BV/talk-desktop/releases/download/v#{version}/Xenia.Talk-macos-universal.zip",
      verified: "github.com/Krateos-BV/talk-desktop/"
  name "Xenia Talk"
  desc "Desktop client for Xenia Talk, based on Nextcloud Talk"
  homepage "https://xeniacloud.eu/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Xenia Talk.app"

  zap trash: [
    "~/Library/Application Support/Xenia Talk",
    "~/Library/Preferences/eu.xeniacloud.talk.mac.plist",
  ]

  caveats do
    <<~EOS
      Xenia Talk is a fork of Nextcloud Talk Desktop, distributed under the
      AGPLv3. Corresponding source: https://github.com/Krateos-BV/talk-desktop

      Xenia Talk is not affiliated with, or endorsed by, Nextcloud GmbH.

      This build is neither signed nor notarized by Apple, so Gatekeeper will
      refuse to open it. To run it anyway:

        xattr -d com.apple.quarantine "/Applications/Xenia Talk.app"
    EOS
  end
end
