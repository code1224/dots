#!/bin/bash

WALL_DIR="$HOME/Imágenes/wallpapers/"

# Ensure awww daemon is running
if ! pidof awww-daemon >/dev/null; then
    awww-daemon &
    sleep 0.5
fi

# Full rewritten premium acrylic theme
GRID_THEME='
@theme "/home/aaron/.cache/wal/colors-rofi-dark.rasi"
* {
    background-color:   rgba(23, 21, 10, 0.75);
    background-alt:   rgba(23, 21, 10, 0.75);
    font: " Iosevka term heavy 12.5";
    border-radius: 6px;
    background-image: transparent;

}

window {
    width: 820px;
    height: 400px;
    anchor: center;
    location: center;
    border: 0px;
    padding: 18px;
}

mainbox {
    background-color: @background;
    spacing: 14px;
    children: [ inputbar, listview ];
}

inputbar {
    padding: 12px 16px;
    background-color: #ffffff12;
    children: [ prompt, entry ];
}

prompt {
    enabled: true;
    text-color: @foreground;
    background-color: transparent;
    margin: 0px 8px 0px 0px;
   placeholder: "search";
}

entry {
    placeholder: "Search wallpaper...";
    placeholder-color: @foreground;
    text-color: @foreground;
    background-color: transparent;
}

listview {
    columns: 3;
    lines: 1;
    flow: horizontal;
    fixed-height: true;
    fixed-columns: true;
    cycle: false;
    scrollbar: false;
    spacing: 16px;
//    background-color: transparent;
}

element {
    orientation: vertical;
    padding: 10px;
    spacing: 10px;
    background-color: transparent;
}

element selected.normal {
    //background-color: g;
    border: 0px;
}

element selected.active {
   // background-color: #89b4fa33;
    border: 0px;
}

element selected.urgent {
   // background-color: #89b4fa33;
    border: 2px;
    border-color: #89b4fa;
}

element-icon {
    size: 210px;
    horizontal-align: 0.5;
    vertical-align: 0.5;
    border-radius: 14px;
    background-color: transparent;
}

element-text {
    horizontal-align: 0.5;
    text-color: #ffffffdd;
    background-color: transparent;
}

'

SELECTED=$(
for img in "$WALL_DIR"/*; do
    [[ "$img" =~ \.(jpg|jpeg|png|webp|PNG|JPG)$ ]] || continue
    printf "%s\0icon\x1f%s\n" "$(basename "$img")" "$img"
done | rofi \
-dmenu \
-theme-str "$GRID_THEME" \
-name "wallpaper-picker"
)

if [ -n "$SELECTED" ]; then
    awww img "$WALL_DIR/$SELECTED" \
        --transition-type center \
        --transition-duration 1 \
	--transition-fps 60 

wal -i "$WALL_DIR/$SELECTED" -n -s

fi
