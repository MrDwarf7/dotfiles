from typing import Optional
import argparse
import sys


class StringLiteralContainer:
    """
    Container for large string literals or constants
    so that IDE hovers show docstrings instead of the literal value(s).
    """

    raw_text: str

    def raw(self) -> str:
        """
        Retrieves the raw string literal stored in the container.
        """
        return self.raw_text

    def __str__(self) -> str:
        """
        Prints self's raw text when printed,
        for easier debugging and use in the main program.
        """
        return self.raw_text

    def __repr__(self) -> str:
        """
        Prints a more detailed representation of the container,
        showing the class name
        """
        class_name = self.__class__.__name__
        return f"{class_name}(raw_text={self.raw_text!r})"


class About(StringLiteralContainer):
    def __init__(self) -> None:
        super().__init__()
        self.raw_text = """
Designed to be used with `ncspot` keybindings, but can be adapted if needed.

This program takes a list of keybindings in the format
"key -> command" and groups them by command,
showing all keys that trigger the same command together.
The output is sorted alphabetically by command for easier readability.
        """


COLORS_TOKYO_NIGHT: dict[str, str] = {
    "background": "#1a1b26",
    "primary": "#9aa5ce",
    "secondary": "#414868",
    "title": "#00FFFF",
    "playing": "#7aa2f7",
    "playing_selected": "#bb9af7",
    "playing_bg": "#24283b",
    "highlight": "#c0caf5",
    "highlight_bg": "#2E334B",
    # highlight_bg = "#24283b" ## more subtle
    # error: "#414868",
    "error": "#000000",
    "error_bg": "#f7768e",
    "statusbar": "#ff9e64",
    "statusbar_progress": "#7aa2f7",
    "statusbar_bg": "#1a1b26",
    "cmdline": "#c0caf5",
    "cmdline_bg": "#24283b",
    "search_match": "#f7768e",
}


class Colors:
    colors: dict[str, str]

    def __init__(self) -> None:
        # //

        colors = COLORS_TOKYO_NIGHT

        self.colors: dict[str, str] = colors

    def __getitem__(self, key: str) -> str:
        return self.colors[key]

    def __setitem__(self, key: str, value: str) -> None:
        self.colors[key] = value

    def __str__(self) -> str:
        return str(self.colors)


class KeyBindings(StringLiteralContainer):
    raw_text: str

    def __init__(self) -> None:
        """
        Text from the `ncspot` help menu, which lists all keybindings
        in the format "key -> command".
        """
        super().__init__()
        self.raw_text = """
+ -> volup 1
- -> voldown 1
. -> playnext; move down 1
< -> previous
> -> next
? -> help
Backspace -> back
Ctrl+a -> move left 1
Ctrl+d -> move down 20
Ctrl+e -> noop
Ctrl+h -> seek -1000
Ctrl+l -> seek +1000
Ctrl+n -> next
Ctrl+p -> previous
Ctrl+r -> redraw
Ctrl+s -> noop
Ctrl+u -> move up 20
Ctrl+v -> insert
Ctrl+y -> save queue
Down -> move down 1
End -> move bottom
Enter -> play
Esc -> back
F1 -> focus search
F2 -> focus queue
F3 -> focus library
F8 -> focus cover
Home -> move top
Left -> move left 1
PageDown -> noop
PageUp -> noop
Right -> move right 1
Shift+Down -> shift down 1
Shift+Up -> shift up 1
Shift+a -> goto album
Shift+b -> seek -10000
Shift+c -> clear
Shift+f -> seek +10000
Shift+g -> move bottom
Shift+h -> seek -10000
Shift+j -> shift down 1
Shift+k -> shift up 1
Shift+l -> seek +10000
Shift+m -> open current
Shift+n -> jumpprevious
Shift+o -> similar current
Shift+p -> playpause
Shift+q -> quit
Shift+s -> stop
Shift+u -> update
Shift+x -> share current
Space -> playpause
Up -> move up 1
[ -> voldown 5
] -> volup 5
a -> goto artist
b -> focus library; move right 5
c -> move playing
d -> delete
e -> focus library
f -> seek +1000
g -> move top
h -> move left 1
j -> move down 1
k -> move up 1
l -> move right 1
m -> open selected
n -> jumpnext
o -> similar selected
p -> queue; move down 1
q -> focus queue
r -> repeat
s -> shuffle
x -> share selected
y -> save
z -> shuffle
        """


type ContainerType = dict[str, list[str]] | dict[str, str]


def max_of_str(container: ContainerType) -> int:
    """
    Takes a 'container' of type T, (eg. dict[str, list[str]] or dict[str, str])
    and returns the maximum length of the keys in the container.

    Used for formatting text output by loosely simulating elastic tabs
    """

    return max(len(length_item) for length_item in container)


def hex_to_rgb(hex_str: str) -> tuple[int, ...]:
    """
    Takes a standard hex color string ( eg. "#1a1b26" )
    and converts it to an RGB tuple (26, 27, 38).
    """
    hex_str = hex_str.lstrip("#")
    return tuple(int(hex_str[i : i + 2], 16) for i in (0, 2, 4))


def print_colors(colors: Colors) -> None:
    """
    Print the set of colors in a nice format,
    showing the color name, a swatch of the color,
    """
    print("Tokyo Night Colors:")
    # max_key_len = max(len(key) for key in COLORS)
    max_key_len = max_of_str(colors.colors)
    for key, hex_val in colors.colors.items():
        r, g, b = hex_to_rgb(hex_val)
        block = "██████████"  # 10 wide

        swatch = f"\033[38;2;{r};{g};{b}m{block}\033[0m"
        fg_text = f"\033[38;2;{r};{g};{b}m{hex_val.upper()}\033[0m"
        print(f"{key.ljust(max_key_len + 2)} {swatch}    {fg_text}")


def parse_keybindings(raw_text: str) -> dict[str, list[str]] | None:
    """
    Parse raw text to dict, mapping command -> list of keys (appearance order).
    """
    binds: dict[str, list[str]] = {}
    for raw_line in raw_text.splitlines():
        line = raw_line.strip()
        if not line or " ->" not in line:
            continue
        key, command = [part.strip() for part in line.split(" -> ", 1)]
        binds.setdefault(command, []).append(key)
    return binds


def print_grouped(binds: dict[str, list[str]]) -> None:
    """Print the grouped keybindings in a nicely aligned format."""
    if not binds:
        print("No valid keybindings found.")
        return
    print("Grouped keybindings (by command):\n")
    max_len = max_of_str(binds)
    # max(len(cmd) for cmd in binds)
    for command in sorted(binds):
        keys = binds[command]
        print(f"{command:<{max_len}} : {', '.join(keys)}")


def parse_args() -> argparse.Namespace | None:
    """
    Small function to parse command line arguments. Currently does not accept
    any arguments.
    Mostly for help text handling.
    """
    parser = argparse.ArgumentParser(
        description=About().raw(),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    # optional 'b' or 'binds' arg, where we run the standard stuff
    parser.add_argument(
        "-b",
        "--binds",
        action="store_true",
        help="Parse the keybindings and print them grouped by command.",
    )
    parser.add_argument(
        "-c",
        "--colors",
        action="store_true",
        help="Print the Tokyo Night color palette and exit.",
    )

    args = parser.parse_args()

    # Only colors
    if args.colors and not args.binds:
        print_colors(Colors())
        return None

    # Only binds
    if args.binds and not args.colors:
        return args

    # both with newline between
    if args.colors and args.binds:
        print_colors(Colors())
        print()  # add a newline between sections
        return args

    return args


def main() -> int:
    """
    Process command line arguments and execute the appropriate functionality.
    """
    args = parse_args()
    if args is None:
        return 0  # help or colors

    binds = parse_keybindings(KeyBindings().raw())
    if binds is None:
        return 2
    print_grouped(binds)

    return 0


if __name__ == "__main__":
    ec = main()
    if ec != 0:
        print(f"Exited with code {ec}")
        sys.exit(ec)
