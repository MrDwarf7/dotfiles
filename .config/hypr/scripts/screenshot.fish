#!/usr/bin/env fish

# Check for required tools
for tool in grim slurp wl-copy
    if not command -v $tool >/dev/null
        echo "Error: $tool is not installed." >&2
        exit 1
    end
end

# Set the pictures directory
if set -q XDG_PICTURES_DIR
    set pics $XDG_PICTURES_DIR/Screenshots
else
    set pics $HOME/Pictures/Screenshots
end

# Ensure the directory exists
mkdir -p $pics

# Function to take a screenshot
function take_screenshot
    set type $argv[1]
    set output_path ""
    set now (date +%Y_%m_%d__%H:%M:%S)

    switch $type
        case region
            # Generate a timestamped filename for region screenshots
            set output_path "$pics/screenshot_region_$now.png"
            if not grim -g (slurp) $output_path
                echo "Error: Failed to take region screenshot." >&2
                return 1
            end
        case full
            # Use a fixed path for full-screen screenshots
            # set output_path "$HOME/Pictures/screenshot.png"
            set output_path "$pics/screenshot_fullscreen_$now.png"

            if not grim $output_path
                echo "Error: Failed to take full-screen screenshot." >&2
                return 1
            end
        case '*'
            echo "Error: Invalid screenshot type. Use 'region' or 'full'." >&2
            return 1
    end

    # Copy the screenshot to the clipboard
    if test -e $output_path
        cat $output_path | wl-copy
        echo "Screenshot saved to $output_path and copied to clipboard."
        return 0
    else
        echo "Error: Screenshot file not found." >&2
        return 1
    end
end

# Check if an argument is provided
if test (count $argv) -eq 0
    echo "Usage: $0 <region|full>" >&2
    exit 1
end

# Call the function with the provided argument
take_screenshot $argv[1]
