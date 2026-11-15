cask "nepali-sambat" do
  version "2.1.0"
  sha256 "e5eac310b3e593e3b1bb259d175da12aa6b15046a907714aa2b0d2aab3e21684"

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
