import os
import re
import subprocess
import json
from datetime import datetime
from json.decoder import JSONDecodeError

DEFAULT_TEMPLATE_USERNAME = r"$env:USERNAME"

home_profile = os.environ.get("HOME_PROFILE")
user_home = os.environ.get("USERPROFILE")

date_str = datetime.now().strftime("%Y_%m_%d")

# Uses cmd commands, now pwsh
file_command_map = {
    # scoop
    "scoop": "scoop list",
    "scoop_export": "scoop export",
    # end scoop
    "gh_cli_extensions": "gh extension list",
    #
    # python
    "pip_list": "python3 -m pip list",
    "pip_freeze": "python3 -m pip freeze",
    "uv_pip_list": "uv pip list",
    "uv_tool_list": "uv tool list",
    # end python
    #
    # rust
    "cargo_list": "cargo --list",
    "cargo_bin_dir": f"dir {user_home}\\.cargo\\bin",
    "cargo_binstall_dir": f"type {user_home}\\.cargo\\binstall\\crates-v1.json | jq",  # This isn't actually valid JSON, that's fine
    "cargo_bin_list": "cargo install-update -l",
    # end rust
    #
    # node
    "npm_global": "npm list -g",
    "pnpm": "pnpm list -g",
    # "yarn_global": "yarn global list",
    # end node
}


def run_command(command):
    try:
        # Debugging purposes
        # print(f"Run res: {subprocess.run(command, shell=True, check=True)}")
        output = subprocess.check_output(
            command, shell=True, text=True, stderr=subprocess.STDOUT
        )
        return output
    except Exception as e:
        print(f"Error: {e}")
        return None


def write_out(filename, data) -> None:
    print(f"Writing to {filename}")
    if filename.endswith(".json"):
        with open(filename, "w") as f:
            json.dump(data, f, indent=2)
            print(f"Generated: {filename}")
        return  # Let the scope finish for file closure/cleanup
    else:
        with open(filename, "w") as f:
            f.write(data)
    print(f"Generated: {filename}")


def create_file_path(filename_base, output_dir=None) -> str:
    filename = ""
    suffix = (
        "work"
        if home_profile == "False" or home_profile == "false" or home_profile is False
        else "home"
    )
    if output_dir is not None:
        filename = os.path.join(output_dir, f"{date_str}_{filename_base}_{suffix}.txt")
    else:
        filename = f"{date_str}_{filename_base}_{suffix}.txt"
    return filename


def dump_mapped(output_dir) -> None:
    for filename_base, command in file_command_map.items():
        file_path = create_file_path(filename_base=filename_base, output_dir=output_dir)
        print(f"\nCommand: {command}")
        result = run_command(command=command)

        if result is not None:  # This is 'Ok', command successful and produced output
            try:
                # print(f"Parsing result as JSON: {result}")
                # We attempt to parse the result as JSON. If it fails we just write it normally; as a txt file
                result = json.loads(result)
                file_path = file_path.replace(".txt", ".json")
                print("Write json")
                write_out(filename=file_path, data=result)

            except JSONDecodeError as _:
                print("Write default")
                write_out(filename=file_path, data=result)

            except subprocess.CalledProcessError as spcpe:
                print(f"Error: {spcpe}")
                continue
            except FileNotFoundError as fnfe:
                print(f"Error: {fnfe}")
                continue


def clean(file_path, replacement=DEFAULT_TEMPLATE_USERNAME) -> None:
    print(f"Removing username from file: {file_path}")

    try:
        with open(file_path, "r", encoding="utf-8") as file:
            # Get initial content
            content = file.read()

            # Remove unicode characters
            content = re.sub(r"\x1b\[[ -?]*[@-~]", "", content)

            # Remove username from file
            content = re.sub(
                r"C:\\Users\\([A-zA-Z0-9._-]+)\\",
                rf"C:\\Users\\{replacement}\\",
                content,
            )

            with open(file_path, "w", encoding="utf-8") as f:
                f.write(content)

    except FileNotFoundError as fnfe:
        print(f"Error: {fnfe}")
        return None
    except re.error as ree:
        print(f"Error: {ree}")
        return None
    except Exception as e:
        print(f"Error: {e}")
        return None


def main():
    output_dir = date_str

    print(f"Make directory if not exists > {output_dir}")
    os.makedirs(output_dir, exist_ok=True)

    print("Dump mapped >")
    dump_mapped(output_dir=output_dir)
    print()

    for file in os.listdir(output_dir):
        file_path = os.path.join(output_dir, file)
        if os.path.isfile(file_path):
            clean(file_path=file_path)


if __name__ == "__main__":
    print("Generating...")
    main()
