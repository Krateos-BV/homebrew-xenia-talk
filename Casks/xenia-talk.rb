cask "xenia-talk" do
  version "2.3.1-beta-xenia.1"
  sha256 "6cf7b002fd4a3c825206eac325612a1607df61ba8c82d5ff8e112756939472bf"

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
