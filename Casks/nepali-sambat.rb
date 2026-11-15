cask "nepali-sambat" do
  version "2.2.2"
  sha256 "e6077f047a96865a1b9c059bb71d39237ff70b8a296d4f6882f79bd93e222c47"

  url "https://github.com/OfficialBishal/nepali-sambat/releases/download/v#{version}/NepaliSambat-#{version}.dmg"
  name "Nepali Sambat"
  desc "Nepali (Bikram Sambat) menu bar calendar that follows Nepal time"
  homepage "https://github.com/OfficialBishal/nepali-sambat"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Nepali Sambat.app"
  binary "#{appdir}/Nepali Sambat.app/Contents/Helpers/sambat"

  # The app is ad-hoc signed (not notarized); clear the download quarantine so it opens normally.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Nepali Sambat.app"],
        must_succeed: false
  end

  uninstall quit: "com.officialbishal.sambat"

  zap trash: [
    "~/Library/Application Support/Sambat",
    "~/Library/Preferences/com.officialbishal.sambat.plist",
    "~/Library/Preferences/com.officialbishal.nepali-patro.plist",
  ]
end
