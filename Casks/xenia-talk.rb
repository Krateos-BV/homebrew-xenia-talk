cask "xenia-talk" do
  version "26.11.20.0"
  sha256 "b980a6d986ba77b06944d9fee3f3e05458a2ac7e93df45c657030d12d92f4f53"

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

  caveats <<~EOS
    Xenia Talk is a fork of Nextcloud Talk Desktop, distributed under the
    AGPLv3. Corresponding source: https://github.com/Krateos-BV/talk-desktop

    Xenia Talk is not affiliated with, or endorsed by, Nextcloud GmbH.
  EOS
end
