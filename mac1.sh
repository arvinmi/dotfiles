#!/bin/zsh
# This second shell script will help to install essentials

# For building/rebuilding dotfiles
# cd dotfiles
# sh mac1.sh

echo "Hello $(whoami)! Let's get you set up."

# Close System Settings panes, to prevent them from overriding
osascript -e "tell application 'System Preferences' to quit"

# Ask for administrator password upfront
sudo -v

# Keep Alive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Xcode CLI
xcode-select --install

# Install Homebrew aarch64
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Homebrew x86
arch --x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Mas install setup
brew update && brew upgrade
brew install mas

# Homebrew install packages
brew bundle --file=~/Brewfile

# Homebrew cleanup
brew cleanup
brew autoremove

###############################################################################
# Manual System Configuration                                                 #
###############################################################################

# NETWORK DNS SETUP
sudo networksetup -setdnsservers "Wi-Fi" 100.100.100.100 9.9.9.9 1.1.1.1
sudo networksetup -setdnsservers "USB 10/100/1000 LAN" 100.100.100.100 9.9.9.9 1.1.1.1
sudo networksetup -setdnsservers "USB 10/100/1000 LAN 2" 100.100.100.100 9.9.9.9 1.1.1.1
# temporarily disable DNS servers
# sudo networksetup -setdnsservers "Wi-Fi" empty

# TAILSCALE SETUP (DEPRECATED)
# sudo /opt/homebrew/bin/tailscaled install-system-daemon
# uninstall daemon
# sudo tailscaled uninstall-system-daemon

# TAILSCALE SETUP
# sudo brew services start tailscale

# PARALLELS INSTALL
# wget https://www.parallels.com/directdownload/pd/?experience=enter_key

# MINICONDA INSTALL
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
# chmod +x Miniconda3-latest-MacOSX-arm64.sh
# bash ./Miniconda3-latest-MacOSX-arm64.sh
# conda config --add channels conda-forge
# conda config --set channel_priority strict

# SKYPILOT INSTALL
# conda create -y -n sky python=3.9
# git clone https://github.com/skypilot-org/skypilot.git "${HOME}/Documents/code/build/skypilot"
# cd skypilot
# pip install ".[all]"

# STEELSERIES EXACTMOUSE TOOL INSTALL (deprecated with linearmouse)
# wget http://downloads.steelseriescdn.com/drivers/tools/steelseries-exactmouse-tool.dmg

# SETUP GPG KEY FOR GIT
# gpg --full-generate-key
# gpg --list-secret-keys --keyid-format LONG
# gpg --armor --export PUB_KEY
# git config --global commit.gpgsign true
# git config --global user.signingkey PUB_KEY
# git config --global gpg.program /opt/homebrew/bin/gpg
# check `~/.gitconfig` for changes

# SETUP GPG KEY WITH KEY
# mkdir -p ~/.gnupg
# echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
# echo "use-agent" >> ~/.gnupg/gpg.conf

# SETUP MANUAL CONFIG
# set 'Terminal.app' config
# set 'Rectangle.app' config
# set 'iTerm.app' config

# SET TRACKPAD SETTING
# set 'swipe with two or three fingers' in System Settings

# SET WALLPAPER
# set wallpaper to black in System Settings

# SET HOTKEYS IN SYSTEM SETTINGS
# cmd - e : toggle show desktop
# cmd - a : toggle mission control
# alt - 1-8 : toggle spaces 1-8
# alt - h : toggle left a space
# alt - l : toggle right a space

# SET KEYBOARD LAYOUT IN SYSTEM SETTINGS
# set keyboard > input sources > Unicode Hex Input (w/ use natural selection)

# FULL DISK ACCESS (deprecated)
# "/bin/bash"

# SET RCLONE CONFIG
# For 2 volumes

# NVIM INSTALL AUTOFORMATTERS
# install "stylua", "black", "clang-format", "prettier"

# CARGO INSTALL
# curl https://sh.rustup.rs -sSf | sh -s -- -y

# NPM PKGS INSTALL
# npm install --global

###############################################################################
# Auto System Configuration                                                    #
###############################################################################

# SDKMAN INSTALL
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

# TMUX TPM INSTALL
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# TMUX SOURCE
tmux source-file ~/.tmux.conf

# LAUNCHD START
launchctl load "${HOME}/Library/LaunchAgents/com.user.backups.plist"
launchctl load "${HOME}/Library/LaunchAgents/com.user.backups.local.plist"
sudo launchctl load "/Library/LaunchDaemons/com.user.sleepblock.plist"
sudo launchctl load "/Library/LaunchDaemons/com.user.sleepblock.guard.plist"
# launchctl list | grep com.user.backups
# launchctl list | grep com.user.backups.local
# sudo launchctl list | grep com.user.sleepblock
# sudo launchctl list | grep com.user.sleepblock.guard

# SKHD START
chmod +x "${HOME}/dotfiles/mac/scripts/scripts/open_iterm2.sh"
skhd --stop-service
skhd --start-service

###############################################################################
# MacOS Changes                                                               #
###############################################################################

# General: Disable sound effects on boot

# General: Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# General: Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# General: Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# General: Automatically quit printer app once print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# General: Move window by clicking anywhere (cmd + ctrl)
defaults write -g NSWindowShouldDragOnGesture -bool true

# General: Disable crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# General: Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# General: Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# General: Disable auto-correct
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# SSD: Turn off safe-sleep mode
# sudo pmset -a hibernatemode 3 && sudo pmset -a autopoweroff 0

# Inputs: Enable tap to click for this user and for login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Inputs: Increase tracking speed
defaults write -g com.apple.trackpad.scaling -float 100.0

# Inputs: Enable three finger drag on trackpad
defaults write http://com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -int 1
defaults write http://com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

# Inputs: Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# TInputs: Set a fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Inputs: Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Inputs: Save screenshots to desktop
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Inputs: Save screenshots in JPG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "jpg"

# Inputs: Disable screenshot thumbnail previews
defaults write com.apple.screencapture show-thumbnail -bool TRUE

# Inputs: Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Inputs: Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Finder: Set Desktop as default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Finder: Show icons for hard drives, servers, and removable media on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: When performing a search, search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Finder: Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Finder: Reduce spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0.2

# Finder: Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Finder: Automatically open a new Finder window when a volume is mounted
# defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
# defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
# defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Finder: Use stacks for icons on desktop and group by tags

# Finder: Decrease size of icons on desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 36" ~/Library/Preferences/com.apple.finder.plist

# Finder: Use column view in all Finder windows by default
# Four-letter codes for other view modes: `icnv`, `clmv`, `Flwv`, `Nlsv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Finder: Show ~/Library folder
# chflags nohidden ~/Library

# Finder: Show /Volumes folder
# sudo chflags nohidden /Volumes

# Dock: Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Dock: Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Dock: Automatically hide and show Dock
defaults write com.apple.dock autohide -bool true

# Dock: Add icons to dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Applications/Launchpad.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Cursor.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# Dock: Change dock size
defaults write com.apple.dock tilesize -integer 47

# Dock: Add spacer on right side of dock for open applications
# defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'; killall Dock

# Dock: Set autohide animation
defaults write com.apple.dock autohide-delay -float 0;killall Dock

# Dock: Enable hidden applications translucent view
defaults write com.apple.Dock showhidden -bool NO;killall Dock

# Dock: Disable toggle for adjusting dock size
defaults write com.apple.dock size-immutable -bool true;killall Dock

# Dock: Enable toggle for adjusting dock size
# defaults write com.apple.dock size-immutable -bool false;killall Dock

# Safari: Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Safari: Press Tab to highlight each item on a web page
# defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Safari: Show full URL in address bar (note: this still hides scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Safari: Set Safari’s home page to `about:blank` for faster loading
# defaults write com.apple.Safari HomePage -string "about:blank"

# Safari: Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Safari: Allow hitting Backspace key to go to previous page in history
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Safari: Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Safari: Disable Safari’s thumbnail cache for History and Top Sites
# defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Safari: Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Safari: Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Safari: Remove useless icons from Safari’s bookmarks bar
# defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Safari: Enable Develop menu and Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Safari: Add a context menu item for showing Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Safari: Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

# Safari: Disable auto-correct
# defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Safari: Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Safari: Disable plug-ins
# defaults write com.apple.Safari WebKitPluginsEnabled -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false

# Safari: Disable Java
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false

# Safari: Block pop-up windows
# defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Safari: Disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# Safari: Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Safari: Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# Mail: Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Mail: Display emails in threaded mode, sorted by date (oldest at top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
# defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Spotlight: Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
#   MENU_DEFINITION
#   MENU_CONVERSION
#   MENU_EXPRESSION
#   MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
#   MENU_WEBSEARCH             (send search queries to Apple)
#   MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "CALCULATOR";}' \
  '{"enabled" = 1;"name" = "CONTACT";}' \
  '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 1;"name" = "DEVELOPER";}' \
  '{"enabled" = 1;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 0;"name" = "FONTS";}' \
  '{"enabled" = 1;"name" = "IMAGES";}' \
  '{"enabled" = 1;"name" = "MAIL_AND_MESSAGES";}' \
  '{"enabled" = 1;"name" = "MOVIES";}' \
  '{"enabled" = 1;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "OTHER";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SIRI_SUGGESTIONS";}' \
  '{"enabled" = 1;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_SETTINGS";}' \
  '{"enabled" = 0;"name" = "WEBSITE";}'

# Terminal: Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Terminal: Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Terminal: Disable annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

# Time Machine: Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Activity Monitor: Show main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Activity Monitor: Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Activity Monitor: Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Utils: Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Utils: Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Utils: Set mouse sense
defaults write .GlobalPreferences com.apple.mouse.linear 1

# Utils: Set mouse acceleration off
defaults write .GlobalPreferences com.apple.mouse.scaling 1

# App Store: Enable WebKit Developer Tools in Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# App Store: Enable automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# App Store: Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# App Store: Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# App Store: Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Photos: Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Kill affected applications
for app in "Activity Monitor" \
  "Calendar" \
  "cfprefsd" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Mail" \
  "Messages" \
  "Photos" \
  "Safari" \
  "SystemUIServer" \
  "iCal"; do
  killall "${app}" &> /dev/null
done

# Kill dock
killall Dock

echo "           /(| "
echo "          (  : "
echo "         __\  \  _____ "
echo "       (____)  \| "
echo "      (____)|   | "
echo "       (____).__| "
echo "        (___)__.|_____ "

echo " "
echo "Complete. Some of these changes do require a restart to take effect. Next login to everything, perform a speed/cache cleanup, and add all TMs to Settings."
