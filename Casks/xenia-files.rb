cask "xenia-files" do
  version "26.11.11.2"
  sha256 "7d95000c7a53899499a4663497024b7647a17d8b218edfc643462dffad5712fe"

  url "https://github.com/Krateos-BV/files-desktop/releases/download/v#{version}/Xenia-Files-v#{version}-macos-arm64-signed.dmg"
  name "Xenia Files"
  desc "Independently maintained Files sync client, not affiliated with Nextcloud GmbH"
  homepage "https://xeniacloud.eu/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Xenia Files.app"

  uninstall quit: "eu.xeniacloud.desktopclient"

  # Paths derived from APPLICATION_NAME, APPLICATION_REV_DOMAIN and DEVELOPMENT_TEAM
  # in files-desktop NEXTCLOUD.cmake. Check them against a real install before merge.
  zap trash: [
    "~/Library/Application Scripts/eu.xeniacloud.desktopclient.*",
    "~/Library/Application Scripts/HKHX362RBY.eu.xeniacloud.desktopclient",
    "~/Library/Application Support/Xenia Files",
    "~/Library/Caches/Xenia Files",
    "~/Library/Containers/eu.xeniacloud.desktopclient.*",
    "~/Library/Group Containers/HKHX362RBY.eu.xeniacloud.desktopclient",
    "~/Library/Preferences/eu.xeniacloud.desktopclient.plist",
    "~/Library/Preferences/Xenia Files",
  ]

  caveats <<~EOS
    Xenia Files is a fork of the Nextcloud desktop client, distributed under the
    GPLv2 or later. Corresponding source: https://github.com/Krateos-BV/files-desktop

    Xenia Files is not affiliated with, or endorsed by, Nextcloud GmbH.
  EOS
end
