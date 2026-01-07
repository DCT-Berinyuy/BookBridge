# App Icon Setup Instructions

To properly set up your custom app icon for BookBridge:

1. Place your custom `App_Icon.png` file in the root of the project (flutter/book_bridge_app/)

2. Install the flutter_launcher_icons package by adding this to your pubspec.yaml:
   ```yaml
   dev_dependencies:
     flutter_launcher_icons: ^0.13.1
   ```

3. Add the following configuration to your pubspec.yaml:
   ```yaml
   flutter_launcher_icons:
     android: "launcher_icon"
     ios: true
     image_path: "App_Icon.png"
     min_sdk_android: 21 # android version
   ```

4. Run the following command to generate the icons:
   ```bash
   flutter pub get
   dart run flutter_launcher_icons:main
   ```

5. After running the command, the tool will generate properly sized icons for all platforms and replace the default Flutter icons.

Note: The actual App_Icon.png file needs to be at least 1024x1024 pixels for best results.