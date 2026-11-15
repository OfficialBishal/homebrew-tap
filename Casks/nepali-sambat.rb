cask "nepali-sambat" do
  version "2.3.2"
  sha256 "a498964fa8508a93ef8e03649fcaa4672d27f7ca0064c257ea55126c7cefb6e2"

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
