#!/usr/bin/env fish
#

# Check for required tools
for tool in hyprshot wl-copy magick
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
function hdr_to_sdr
    set input_image $argv[1]
    set output_image $argv[2]

    set -l format_spec "zscale=transfer=bt709:primaries=bt709:matrix=bt709:range=full: \
      rangein=full:transferin=smpte2084:primariesin=bt2020:matrixin=bt2020nc"

    # set -l format_spec "format=gbrpf32le,zscale=transfer=linear:npl=1000,tonemap=tonemap=hable:desat=0,zscale=transfer=bt709:matrix=bt709:primaries=bt709:range=full,format=rgba"

    ffmpeg -i $input_image \
      -vf $format_spec \
      -c:v png \
      -strict -1 -frames:v 1 -update 1 "$output_image"

    # ffmpeg -color_trc smpte2084 -color_primaries bt2020 -colorspace bt2020nc \
    # -i $input_image \
    # -vf "format=gbrpf32le,zscale=transfer=linear:npl=1000,tonemap=tonemap=hable:desat=0,zscale=transfer=bt709:matrix=bt709:primaries=bt709:range=full,format=rgba" \
    # -c:v png -frames:v 1 $output_image

end

# Function to take a screenshot
function take_screenshot
    set type $argv[1]
    set now (date +%Y_%m_%d__%H:%M:%S)
    set ext png

    set output_path "$pics"
    set filename "screenshot_$type.$now.$ext"

    switch $type
    case region

        if not hyprshot -m $type -z -o $output_path -f $filename
            echo "Error: Failed to take region screenshot." >&2
            return 1
        end
        hdr_to_sdr "$output_path/$filename" "$output_path/$filename"

    case full
        if not hyprshot -m output -z -o $output_path -f $filename
            echo "Error: Failed to take region screenshot." >&2
            return 1
        end
        hdr_to_sdr "$output_path/$filename" "$output_path/$filename"

    case '*'
        echo "Error: Invalid screenshot type. Use 'region' or 'full'." >&2
        return 1
    end

    printf "Value of path: %s\n" $output_path

    # Copy the screenshot to the clipboard
    if test -e "$output_path/$filename"
        # cat "$output_path/$filename" | wl-copy
        cat "$output_path/$filename" | wl-copy
        echo "Screenshot saved to $output_path/$filename and copied to clipboard."
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
