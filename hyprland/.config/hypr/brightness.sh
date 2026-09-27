 #!/usr/bin/env bash

set -u

case "${1:-}" in
    up)
        exec brightnessctl --quiet set 5%+
        ;;
    down)
       
        brightnessctl --quiet set 5%-
        
        CURRENT=$(brightnessctl -m | awk -F, 'NR==1 {print int($4)}')
        
        if [ "$CURRENT" -lt 15 ]; then
            exec brightnessctl --quiet set 15%
        fi
        ;;
    *)
        printf '%s\n' "Usage: $0 up|down" >&2
        exit 2
        ;;
esac 