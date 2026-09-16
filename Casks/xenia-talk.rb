cask "xenia-talk" do
  version "26.9.13"
  sha256 "ed39605a75b79aeb8029a26ca1ade1f5792d87944d154bfe2ecadeeb3c6ae7e4"

  url "https://github.com/Krateos-BV/talk-desktop/releases/download/v#{version}/Xenia.Talk-macos-universal.zip"
  name "Xenia Talk"
  desc "Independently maintained Talk client, not affiliated with Nextcloud GmbH"
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
