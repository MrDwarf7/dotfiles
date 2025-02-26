import os
import re
import subprocess
import json
from datetime import datetime
from json.decoder import JSONDecodeError


home_profile = os.environ.get("HOME_PROFILE")
user_home = os.environ.get("USERPROFILE")
username = os.environ.get("USERNAME")

date_str = datetime.now().strftime("%Y_%m_%d")

removal_pattern = r"C:\\Users\\.*?\\"


file_command_map = {
    "scoop": "scoop list",
    "scoop_export": "scoop export",
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
    "cargo_bin_dir": f"ls {user_home}\\.cargo\\bin",
    "cargo_binstall_dir": f"cat {user_home}\\.cargo\\binstall\\crates-v1.json",
    # end rust
    #
    # node
    "npm_global": "npm list -g",
    "pnpm": "pnpm list -g",
    "yarn_global": "yarn global list",
    # end node
}


def run_command(command):
    try:
        output = subprocess.check_output(
            command, shell=True, text=True, stderr=subprocess.STDOUT
        )
        return output
    except Exception as e:
        print(f"Error: {e}")
        return None


exacts = ["non_package.txt"]
# def dump_exacts():
#     for file in exacts:
#         filename = f"{date_str}_{file}"
#         with open(filename, "w") as f:
#             # Can add specific logic ?
#             pass
#         print(f"Exacts -- Generated: {filename}")


def write_as_json(filename, data):
    print(f"Writing to {filename}")
    with open(filename, "w") as f:
        json.dump(data, f, indent=2)
    print(f"Generated: {filename}")


def write_as_default(filename, data):
    print(f"Writing to {filename}")
    with open(filename, "w") as f:
        f.write(data)
    print(f"Generated: {filename}")


def dump_mapped(output_dir):
    for filename_base, command in file_command_map.items():
        print()
        suffix = (
            "work"
            if home_profile == "False"
            or home_profile == "false"
            or home_profile is False
            else "home"
        )
        if output_dir is not None:
            filename = os.path.join(
                output_dir, f"{date_str}_{filename_base}_{suffix}.txt"
            )
        else:
            filename = f"{date_str}_{filename_base}_{suffix}.txt"

        result = run_command(command)

        if result is not None:
            try:
                # We attempt to parse the result as JSON
                # If it fails we just write it normally; as a txt file
                data = json.loads(result)
                json_filename = filename.replace(".txt", ".json")
                filename = json_filename  # re-assign required to ensure we still clear anything
                print("Write json")
                write_as_json(json_filename, data)

            except JSONDecodeError as _:
                print("Write default")
                write_as_default(filename, result)
                continue

            except subprocess.CalledProcessError as spcpe:
                print(f"Error: {spcpe}")
                continue
            except FileNotFoundError as fnfe:
                print(f"Error: {fnfe}")
                continue

            print("Removing stuff")
            replace_username(filename)


def replace_username(file_path: str, replacement="USERNAME") -> None:
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            content = file.read()

            new_content = re.sub(
                r"C:\\Users\\([A-zA-Z0-9._-]+)\\",
                rf"C:\\Users\\{replacement}\\",
                content,
            )

            with open(file_path, "w", encoding="utf-8") as f:
                f.write(new_content)
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

    print(f"Make directory if not exists >> {output_dir}")
    os.makedirs(output_dir, exist_ok=True)

    print("Dump mapped >>")
    dump_mapped(output_dir=output_dir)

    # print("Dump exacts >>")
    # dump_exacts()


if __name__ == "__main__":
    print("Generating...")
    main()
