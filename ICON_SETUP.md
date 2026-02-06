# App Icon Customization Guide

The app icon has been set up with a custom calendar icon featuring a checkmark, perfect for the Day Check In app!

## Icon Design

The icon features:
- **Blue circular background** - Modern and clean
- **White calendar** - Represents the daily check-in concept
- **Green checkmark** - Indicates task completion
- **Professional design** - Suitable for all platforms

## Generated Icons

Two icon files have been created:
- `assets/icon/app_icon.png` - Main icon (1024x1024)
- `assets/icon/app_icon_foreground.png` - Foreground for Android adaptive icons

## Applying the Icons

To generate platform-specific icons from these base icons, run:

```bash
# 1. Install dependencies
flutter pub get

# 2. Generate platform icons
flutter pub run flutter_launcher_icons
```

This will automatically generate icons for:
- ✅ Android (including adaptive icons)
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS

## Customizing the Icon

If you want to customize the icon design:

1. **Edit the Python script**: Modify `generate_icon.py` to change colors, shapes, or add elements
2. **Use your own image**: Replace `assets/icon/app_icon.png` with your own 1024x1024 PNG image
3. **Regenerate**: Run `python3 generate_icon.py` (if using the script) or replace the files manually
4. **Apply changes**: Run `flutter pub run flutter_launcher_icons` again

## Requirements

- Python 3 with Pillow library: `pip install Pillow`
- Flutter with `flutter_launcher_icons` package (already configured)

## Icon Colors

Current color scheme:
- Background: Blue (#2196F3)
- Calendar: White
- Checkmark: Green (#4CAF50)

You can modify these in `generate_icon.py` if needed.
