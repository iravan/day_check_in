#!/usr/bin/env python3
"""
Generate app icon for Day Check In app.
This script creates a calendar icon with a checkmark.
Requires Pillow: pip install Pillow
"""

try:
    from PIL import Image, ImageDraw, ImageFont
except ImportError:
    print("Pillow is required. Install it with: pip install Pillow")
    exit(1)

def create_app_icon(size=1024):
    """Create the main app icon"""
    # Create image with transparent background
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Background circle with gradient effect (blue)
    padding = size // 20
    circle_size = size - padding * 2
    
    # Draw background circle
    draw.ellipse(
        [padding, padding, padding + circle_size, padding + circle_size],
        fill=(33, 150, 243, 255),  # Blue color
        outline=None
    )
    
    # Draw calendar base (white rectangle)
    cal_width = int(size * 0.6)
    cal_height = int(size * 0.7)
    cal_x = (size - cal_width) // 2
    cal_y = int(size * 0.15)
    
    # Calendar shadow
    shadow_offset = size // 40
    draw.rectangle(
        [cal_x + shadow_offset, cal_y + shadow_offset, 
         cal_x + cal_width + shadow_offset, cal_y + cal_height + shadow_offset],
        fill=(0, 0, 0, 50)
    )
    
    # Calendar body
    draw.rectangle(
        [cal_x, cal_y, cal_x + cal_width, cal_y + cal_height],
        fill=(255, 255, 255, 255),
        outline=(200, 200, 200, 255),
        width=max(2, size // 200)
    )
    
    # Calendar header (blue)
    header_height = int(cal_height * 0.25)
    draw.rectangle(
        [cal_x, cal_y, cal_x + cal_width, cal_y + header_height],
        fill=(33, 150, 243, 255),
        outline=None
    )
    
    # Calendar grid lines
    line_width = max(1, size // 300)
    # Vertical lines
    for i in range(1, 7):
        x = cal_x + (cal_width * i // 7)
        draw.line(
            [x, cal_y + header_height, x, cal_y + cal_height],
            fill=(220, 220, 220, 255),
            width=line_width
        )
    
    # Horizontal lines
    rows = 5
    for i in range(1, rows):
        y = cal_y + header_height + (cal_height - header_height) * i // rows
        draw.line(
            [cal_x, y, cal_x + cal_width, y],
            fill=(220, 220, 220, 255),
            width=line_width
        )
    
    # Draw checkmark in the first cell
    check_size = int(cal_width * 0.15)
    check_x = cal_x + cal_width // 7 + (cal_width // 7 - check_size) // 2
    check_y = cal_y + header_height + (cal_height - header_height) // rows + ((cal_height - header_height) // rows - check_size) // 2
    
    # Draw checkmark
    check_thickness = max(3, size // 100)
    # Checkmark path
    check_points = [
        (check_x + check_size * 0.2, check_y + check_size * 0.5),
        (check_x + check_size * 0.45, check_y + check_size * 0.75),
        (check_x + check_size * 0.8, check_y + check_size * 0.25),
    ]
    
    # Draw checkmark with smooth lines
    for i in range(len(check_points) - 1):
        draw.line(
            check_points[i] + check_points[i + 1],
            fill=(76, 175, 80, 255),  # Green checkmark
            width=check_thickness
        )
    
    return img

def create_foreground_icon(size=1024):
    """Create foreground icon for adaptive icon (Android)"""
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Draw calendar (simpler version for foreground)
    cal_width = int(size * 0.7)
    cal_height = int(size * 0.8)
    cal_x = (size - cal_width) // 2
    cal_y = int(size * 0.1)
    
    # Calendar body
    draw.rectangle(
        [cal_x, cal_y, cal_x + cal_width, cal_y + cal_height],
        fill=(255, 255, 255, 255),
        outline=(200, 200, 200, 255),
        width=max(2, size // 200)
    )
    
    # Calendar header
    header_height = int(cal_height * 0.25)
    draw.rectangle(
        [cal_x, cal_y, cal_x + cal_width, cal_y + header_height],
        fill=(33, 150, 243, 255),
        outline=None
    )
    
    # Calendar grid
    line_width = max(1, size // 300)
    for i in range(1, 7):
        x = cal_x + (cal_width * i // 7)
        draw.line(
            [x, cal_y + header_height, x, cal_y + cal_height],
            fill=(220, 220, 220, 255),
            width=line_width
        )
    
    rows = 5
    for i in range(1, rows):
        y = cal_y + header_height + (cal_height - header_height) * i // rows
        draw.line(
            [cal_x, y, cal_x + cal_width, y],
            fill=(220, 220, 220, 255),
            width=line_width
        )
    
    # Checkmark
    check_size = int(cal_width * 0.2)
    check_x = cal_x + cal_width // 7 + (cal_width // 7 - check_size) // 2
    check_y = cal_y + header_height + (cal_height - header_height) // rows + ((cal_height - header_height) // rows - check_size) // 2
    
    check_thickness = max(3, size // 100)
    check_points = [
        (check_x + check_size * 0.2, check_y + check_size * 0.5),
        (check_x + check_size * 0.45, check_y + check_size * 0.75),
        (check_x + check_size * 0.8, check_y + check_size * 0.25),
    ]
    
    for i in range(len(check_points) - 1):
        draw.line(
            check_points[i] + check_points[i + 1],
            fill=(76, 175, 80, 255),
            width=check_thickness
        )
    
    return img

if __name__ == '__main__':
    print("Generating app icons...")
    
    # Generate main icon (1024x1024)
    icon = create_app_icon(1024)
    icon.save('assets/icon/app_icon.png', 'PNG')
    print("✓ Created assets/icon/app_icon.png")
    
    # Generate foreground icon for adaptive icon
    foreground = create_foreground_icon(1024)
    foreground.save('assets/icon/app_icon_foreground.png', 'PNG')
    print("✓ Created assets/icon/app_icon_foreground.png")
    
    print("\nIcons generated successfully!")
    print("Now run: flutter pub get")
    print("Then run: flutter pub run flutter_launcher_icons")
