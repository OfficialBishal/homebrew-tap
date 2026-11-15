cask "sambat" do
  version "2.0.0"
  sha256 "9415103e6b32d01bdf5f9e2f7a303a96bc72169a1a00a498fc836e5903d46dc3"

  url "https://github.com/OfficialBishal/sambat/releases/download/v#{version}/Sambat-#{version}.dmg"
  name "Sambat"
  desc "Nepali (Bikram Sambat) menu bar calendar that follows Nepal time"
  homepage "https://github.com/OfficialBishal/sambat"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Sambat.app"
  binary "#{appdir}/Sambat.app/Contents/Helpers/sambat"

  # The app is ad-hoc signed (not notarized); clear the download quarantine so it opens normally.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Sambat.app"],
        must_succeed: false
  end

  uninstall quit: "com.officialbishal.sambat"

  zap trash: [
    "~/Library/Application Support/Sambat",
    "~/Library/Preferences/com.officialbishal.sambat.plist",
    "~/Library/Preferences/com.officialbishal.nepali-patro.plist",
  ]
end
