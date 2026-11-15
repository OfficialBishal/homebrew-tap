cask "nepali-patro" do
  version "1.1.0"
  sha256 "aedbb6be01d75bb7b6fd7d65edf3c845ad78ec9cbe2df38c140ea97852f87577"

  url "https://github.com/OfficialBishal/nepali-patro/releases/download/v#{version}/NepaliPatro-#{version}.dmg"
  name "Nepali Patro"
  desc "Nepali (Bikram Sambat) menu bar calendar that follows Nepal time"
  homepage "https://github.com/OfficialBishal/nepali-patro"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Nepali Patro.app"
  binary "#{appdir}/Nepali Patro.app/Contents/MacOS/patro"

  # The app is ad-hoc signed (not notarized); clear the download quarantine so it opens normally.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Nepali Patro.app"],
        must_succeed: false
  end

  uninstall quit: "com.officialbishal.nepali-patro"

  zap trash: [
    "~/Library/Application Support/NepaliPatro",
    "~/Library/Preferences/com.officialbishal.nepali-patro.plist",
  ]
end
