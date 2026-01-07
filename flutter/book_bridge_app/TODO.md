# App Icon Setup Instructions

The App_Icon.png has been added to the project root. To properly set up your custom app icon for BookBridge:

1. Install the flutter_launcher_icons package by adding this to your pubspec.yaml:
   ```yaml
   dev_dependencies:
     flutter_launcher_icons: ^0.13.1
   ```

2. Add the following configuration to your pubspec.yaml:
   ```yaml
   flutter_launcher_icons:
     android: "launcher_icon"
     ios: true
     image_path: "App_Icon.png"
     min_sdk_android: 21 # android version
   ```

3. Run the following command to generate the properly sized icons:
   ```bash
   flutter pub get
   dart run flutter_launcher_icons:main
   ```

4. After running the command, the tool will generate properly sized icons for all platforms and replace the default Flutter icons.

Note: The App_Icon.png file is already in place (at 1024x1024 pixels) for best results.