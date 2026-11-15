cask "nepali-patro" do
  version "1.0.0"
  sha256 "272abd4f5675022b0a5450e4bdbc9cf6c4e7a0a1a65af401eb60e8bfd73ce10c"

  url "https://github.com/OfficialBishal/nepali-patro/releases/download/v#{version}/NepaliPatro-#{version}.dmg"
  name "Nepali Patro"
  desc "Nepali (Bikram Sambat) menu bar calendar that follows Nepal time"
  homepage "https://github.com/OfficialBishal/nepali-patro"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Nepali Patro.app"
  binary "#{appdir}/Nepali Patro.app/Contents/MacOS/patro"

  # The app is ad-hoc signed (not notarized); clear the download quarantine so it opens normally.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nepali Patro.app"]
  end

  uninstall quit: "com.officialbishal.nepali-patro"

  zap trash: [
    "~/Library/Application Support/NepaliPatro",
    "~/Library/Preferences/com.officialbishal.nepali-patro.plist",
  ]
end
