 #!/usr/bin/env bash

# Folder docelowy
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

# Nazwa pliku z datą i godziną
NAME="screenshot_$(date +%Y%m%d_%H%M%S).png"
FILE="$DIR/$NAME"

# Zrzut całego ekranu (grim)
grim "$FILE"

# Kopiowanie do schowka i wysłanie powiadomienia (Dunst)
if [ -f "$FILE" ]; then
    wl-copy < "$FILE"
    notify-send "Screenshot Saved" "Full screen copied to clipboard and saved." -i "$FILE"
fi 