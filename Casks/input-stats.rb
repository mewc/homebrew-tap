cask "input-stats" do
  version "0.3.10"
  sha256 "b74aea33b8f83ac3d82db775189270da373c983416a9f93b9d3d21abb597f8ab"

  url "https://github.com/mewc/input-stats/releases/download/v#{version}/InputStats.zip"
  name "Input Stats"
  desc "Menu-bar counter for keys, clicks, scroll and mouse distance (never content)"
  homepage "https://input-stats.drummerduck.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Input Stats.app"

  # The release is self-signed (not notarized). Clear quarantine so Gatekeeper
  # doesn't block first launch; the app still needs an Accessibility grant.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Input Stats.app"]
  end

  uninstall quit: "com.mewc.input-stats"

  zap trash: [
    "~/Library/Application Support/TypingStats",
    "~/Library/Preferences/com.mewc.input-stats.plist",
  ]

  caveats <<~EOS
    Input Stats needs Accessibility access to count input events:
      System Settings → Privacy & Security → Accessibility → enable Input Stats
    It only ever counts. Keystrokes are never recorded.
  EOS
end
