require "set"

require "os/mac/version"

module OS::Mac
  SYSTEM_DIRS = [
                  "/",
                  "/Applications",
                  "/Applications/Utilities",
                  "/Incompatible Software",
                  "/Library",
                  "/Library/Application Support",
                  "/Library/Audio",
                  "/Library/Caches",
                  "/Library/ColorPickers",
                  "/Library/ColorSync",
                  "/Library/Components",
                  "/Library/Compositions",
                  "/Library/Contextual Menu Items",
                  "/Library/CoreMediaIO",
                  "/Library/Desktop Pictures",
                  "/Library/Developer",
                  "/Library/Dictionaries",
                  "/Library/DirectoryServices",
                  "/Library/Documentation",
                  "/Library/Extensions",
                  "/Library/Filesystems",
                  "/Library/Fonts",
                  "/Library/Frameworks",
                  "/Library/Graphics",
                  "/Library/Image Capture",
                  "/Library/Input Methods",
                  "/Library/Internet Plug-Ins",
                  "/Library/Java",
                  "/Library/Keyboard Layouts",
                  "/Library/Keychains",
                  "/Library/LaunchAgents",
                  "/Library/LaunchDaemons",
                  "/Library/Logs",
                  "/Library/Messages",
                  "/Library/Modem Scripts",
                  "/Library/OpenDirectory",
                  "/Library/PDF Services",
                  "/Library/Perl",
                  "/Library/PreferencePanes",
                  "/Library/Preferences",
                  "/Library/Printers",
                  "/Library/PrivilegedHelperTools",
                  "/Library/Python",
                  "/Library/QuickLook",
                  "/Library/QuickTime",
                  "/Library/Receipts",
                  "/Library/Ruby",
                  "/Library/Sandbox",
                  "/Library/Screen Savers",
                  "/Library/ScriptingAdditions",
                  "/Library/Scripts",
                  "/Library/Security",
                  "/Library/Speech",
                  "/Library/Spelling",
                  "/Library/Spotlight",
                  "/Library/StartupItems",
                  "/Library/SystemProfiler",
                  "/Library/Updates",
                  "/Library/User Pictures",
                  "/Library/Video",
                  "/Library/WebServer",
                  "/Library/Widgets",
                  "/Library/iTunes",
                  "/Network",
                  "/System",
                  "/System/Library",
                  "/System/Library/Accessibility",
                  "/System/Library/Accounts",
                  "/System/Library/Address Book Plug-Ins",
                  "/System/Library/Assistant",
                  "/System/Library/Automator",
                  "/System/Library/BridgeSupport",
                  "/System/Library/Caches",
                  "/System/Library/ColorPickers",
                  "/System/Library/ColorSync",
                  "/System/Library/Colors",
                  "/System/Library/Components",
                  "/System/Library/Compositions",
                  "/System/Library/CoreServices",
                  "/System/Library/DTDs",
                  "/System/Library/DirectoryServices",
                  "/System/Library/Displays",
                  "/System/Library/Extensions",
                  "/System/Library/Filesystems",
                  "/System/Library/Filters",
                  "/System/Library/Fonts",
                  "/System/Library/Frameworks",
                  "/System/Library/Graphics",
                  "/System/Library/IdentityServices",
                  "/System/Library/Image Capture",
                  "/System/Library/Input Methods",
                  "/System/Library/InternetAccounts",
                  "/System/Library/Java",
                  "/System/Library/KerberosPlugins",
                  "/System/Library/Keyboard Layouts",
                  "/System/Library/Keychains",
                  "/System/Library/LaunchAgents",
                  "/System/Library/LaunchDaemons",
                  "/System/Library/LinguisticData",
                  "/System/Library/LocationBundles",
                  "/System/Library/LoginPlugins",
                  "/System/Library/Messages",
                  "/System/Library/Metadata",
                  "/System/Library/MonitorPanels",
                  "/System/Library/OpenDirectory",
                  "/System/Library/OpenSSL",
                  "/System/Library/Password Server Filters",
                  "/System/Library/PerformanceMetrics",
                  "/System/Library/Perl",
                  "/System/Library/PreferencePanes",
                  "/System/Library/Printers",
                  "/System/Library/PrivateFrameworks",
                  "/System/Library/QuickLook",
                  "/System/Library/QuickTime",
                  "/System/Library/QuickTimeJava",
                  "/System/Library/Recents",
                  "/System/Library/SDKSettingsPlist",
                  "/System/Library/Sandbox",
                  "/System/Library/Screen Savers",
                  "/System/Library/ScreenReader",
                  "/System/Library/ScriptingAdditions",
                  "/System/Library/ScriptingDefinitions",
                  "/System/Library/Security",
                  "/System/Library/Services",
                  "/System/Library/Sounds",
                  "/System/Library/Speech",
                  "/System/Library/Spelling",
                  "/System/Library/Spotlight",
                  "/System/Library/StartupItems",
                  "/System/Library/SyncServices",
                  "/System/Library/SystemConfiguration",
                  "/System/Library/SystemProfiler",
                  "/System/Library/Tcl",
                  "/System/Library/TextEncodings",
                  "/System/Library/User Template",
                  "/System/Library/UserEventPlugins",
                  "/System/Library/Video",
                  "/System/Library/WidgetResources",
                  "/User Information",
                  "/Users",
                  "/Volumes",
                  "/bin",
                  "/boot",
                  "/cores",
                  "/dev",
                  "/etc",
                  "/etc/X11",
                  "/etc/opt",
                  "/etc/sgml",
                  "/etc/xml",
                  "/home",
                  "/libexec",
                  "/lost+found",
                  "/media",
                  "/mnt",
                  "/net",
                  "/opt",
                  "/private",
                  "/private/etc",
                  "/private/tftpboot",
                  "/private/tmp",
                  "/private/var",
                  "/proc",
                  "/root",
                  "/sbin",
                  "/srv",
                  "/tmp",
                  "/usr",
                  "/usr/X11R6",
                  "/usr/bin",
                  "/usr/etc",
                  "/usr/include",
                  "/usr/lib",
                  "/usr/libexec",
                  "/usr/local",
                  "/usr/local/Cellar",
                  "/usr/local/Frameworks",
                  "/usr/local/Library",
                  "/usr/local/bin",
                  "/usr/local/etc",
                  "/usr/local/include",
                  "/usr/local/lib",
                  "/usr/local/libexec",
                  "/usr/local/opt",
                  "/usr/local/share",
                  "/usr/local/share/man",
                  "/usr/local/share/man/man1",
                  "/usr/local/share/man/man2",
                  "/usr/local/share/man/man3",
                  "/usr/local/share/man/man4",
                  "/usr/local/share/man/man5",
                  "/usr/local/share/man/man6",
                  "/usr/local/share/man/man7",
                  "/usr/local/share/man/man8",
                  "/usr/local/share/man/man9",
                  "/usr/local/share/man/mann",
                  "/usr/local/var",
                  "/usr/local/var/lib",
                  "/usr/local/var/lock",
                  "/usr/local/var/run",
                  "/usr/sbin",
                  "/usr/share",
                  "/usr/share/man",
                  "/usr/share/man/man1",
                  "/usr/share/man/man2",
                  "/usr/share/man/man3",
                  "/usr/share/man/man4",
                  "/usr/share/man/man5",
                  "/usr/share/man/man6",
                  "/usr/share/man/man7",
                  "/usr/share/man/man8",
                  "/usr/share/man/man9",
                  "/usr/share/man/mann",
                  "/usr/src",
                  "/var",
                  "/var/cache",
                  "/var/lib",
                  "/var/lock",
                  "/var/log",
                  "/var/mail",
                  "/var/run",
                  "/var/spool",
                  "/var/spool/mail",
                  "/var/tmp",
                ]
                .map(&method(:Pathname))
                .to_set
                .freeze

  # TODO: There should be a way to specify a containing
  #       directory under which nothing can be deleted.
  UNDELETABLE_DIRS = [
                       "~/",
                       "~/Applications",
                       "~/Desktop",
                       "~/Documents",
                       "~/Downloads",
                       "~/Mail",
                       "~/Movies",
                       "~/Music",
                       "~/Music/iTunes",
                       "~/Music/iTunes/iTunes Music",
                       "~/Music/iTunes/Album Artwork",
                       "~/News",
                       "~/Pictures",
                       "~/Pictures/Desktops",
                       "~/Pictures/Photo Booth",
                       "~/Pictures/iChat Icons",
                       "~/Pictures/iPhoto Library",
                       "~/Public",
                       "~/Sites",
                       "~/Library",
                       "~/Library/.localized",
                       "~/Library/Accessibility",
                       "~/Library/Accounts",
                       "~/Library/Address Book Plug-Ins",
                       "~/Library/Application Scripts",
                       "~/Library/Application Support",
                       "~/Library/Application Support/Apple",
                       "~/Library/Application Support/com.apple.AssistiveControl",
                       "~/Library/Application Support/com.apple.QuickLook",
                       "~/Library/Application Support/com.apple.TCC",
                       "~/Library/Assistants",
                       "~/Library/Audio",
                       "~/Library/Automator",
                       "~/Library/Autosave Information",
                       "~/Library/Caches",
                       "~/Library/Calendars",
                       "~/Library/ColorPickers",
                       "~/Library/ColorSync",
                       "~/Library/Colors",
                       "~/Library/Components",
                       "~/Library/Compositions",
                       "~/Library/Containers",
                       "~/Library/Contextual Menu Items",
                       "~/Library/Cookies",
                       "~/Library/DTDs",
                       "~/Library/Desktop Pictures",
                       "~/Library/Developer",
                       "~/Library/Dictionaries",
                       "~/Library/DirectoryServices",
                       "~/Library/Displays",
                       "~/Library/Documentation",
                       "~/Library/Extensions",
                       "~/Library/Favorites",
                       "~/Library/FileSync",
                       "~/Library/Filesystems",
                       "~/Library/Filters",
                       "~/Library/FontCollections",
                       "~/Library/Fonts",
                       "~/Library/Frameworks",
                       "~/Library/GameKit",
                       "~/Library/Graphics",
                       "~/Library/Group Containers",
                       "~/Library/Icons",
                       "~/Library/IdentityServices",
                       "~/Library/Image Capture",
                       "~/Library/Images",
                       "~/Library/Input Methods",
                       "~/Library/Internet Plug-Ins",
                       "~/Library/InternetAccounts",
                       "~/Library/iTunes",
                       "~/Library/KeyBindings",
                       "~/Library/Keyboard Layouts",
                       "~/Library/Keychains",
                       "~/Library/LaunchAgents",
                       "~/Library/LaunchDaemons",
                       "~/Library/LocationBundles",
                       "~/Library/LoginPlugins",
                       "~/Library/Logs",
                       "~/Library/Mail",
                       "~/Library/Mail Downloads",
                       "~/Library/Messages",
                       "~/Library/Metadata",
                       "~/Library/Mobile Documents",
                       "~/Library/MonitorPanels",
                       "~/Library/OpenDirectory",
                       "~/Library/PDF Services",
                       "~/Library/PhonePlugins",
                       "~/Library/Phones",
                       "~/Library/PreferencePanes",
                       "~/Library/Preferences",
                       "~/Library/Printers",
                       "~/Library/PrivateFrameworks",
                       "~/Library/PubSub",
                       "~/Library/QuickLook",
                       "~/Library/QuickTime",
                       "~/Library/Receipts",
                       "~/Library/Recent Servers",
                       "~/Library/Recents",
                       "~/Library/Safari",
                       "~/Library/Saved Application State",
                       "~/Library/Screen Savers",
                       "~/Library/ScreenReader",
                       "~/Library/ScriptingAdditions",
                       "~/Library/ScriptingDefinitions",
                       "~/Library/Scripts",
                       "~/Library/Security",
                       "~/Library/Services",
                       "~/Library/Sounds",
                       "~/Library/Speech",
                       "~/Library/Spelling",
                       "~/Library/Spotlight",
                       "~/Library/StartupItems",
                       "~/Library/StickiesDatabase",
                       "~/Library/Sync Services",
                       "~/Library/SyncServices",
                       "~/Library/SyncedPreferences",
                       "~/Library/TextEncodings",
                       "~/Library/User Pictures",
                       "~/Library/Video",
                       "~/Library/Voices",
                       "~/Library/WebKit",
                       "~/Library/WidgetResources",
                       "~/Library/Widgets",
                       "~/Library/Workflows",
                     ]
                     .map { |x| Pathname(x.sub(%r{^~(?=(/|$))}, Dir.home)).expand_path }
                     .to_set
                     .union(SYSTEM_DIRS)
                     .freeze

  def system_dir?(dir)
    SYSTEM_DIRS.include?(Pathname.new(dir).expand_path)
  end

  def undeletable?(dir)
    UNDELETABLE_DIRS.include?(Pathname.new(dir).expand_path)
  end

  alias release version
end
