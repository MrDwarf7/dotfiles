import json
import argparse


def sort_dict_recursive(data):
    """Recursively sort dictionary keys and return a new sorted dict."""
    if isinstance(data, dict):
        return {k: sort_dict_recursive(data[k]) for k in sorted(data.keys())}
    elif isinstance(data, list):
        return [sort_dict_recursive(item) for item in data]
    else:
        return data


def sort_json_file(input_file, output_file):
    # Read the JSON file
    with open(input_file, "r") as f:
        data = json.load(f)

    # Sort the "apps" array by "Name" and sort fields within each app
    if "apps" in data:
        data["apps"] = sorted(data["apps"], key=lambda x: x["Name"])
        data["apps"] = [sort_dict_recursive(app) for app in data["apps"]]

    # Sort the "buckets" array by "Name" and sort fields within each bucket
    if "buckets" in data:
        data["buckets"] = sorted(data["buckets"], key=lambda x: x["Name"])
        data["buckets"] = [sort_dict_recursive(bucket) for bucket in data["buckets"]]

    if "apps" not in data and "buckets" not in data:
        raise ValueError("No 'apps' or 'buckets' array found in the JSON file.")

    # Write the sorted JSON to a new file with indentation
    with open(output_file, "w") as f:
        json.dump(data, f, indent=4)


def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(
        description="Sort a JSON file's arrays by 'Name' and fields alphabetically."
    )
    parser.add_argument("input_file", type=str, help="Path to the input JSON file")
    parser.add_argument(
        "output_file", type=str, help="Path to the output sorted JSON file"
    )

    # Parse arguments
    args = parser.parse_args()

    # Call the sorting function with parsed arguments
    try:
        sort_json_file(args.input_file, args.output_file)
        print(f"Sorted JSON written to {args.output_file}")
    except ValueError as e:
        print(f"ValueError: {e}")


if __name__ == "__main__":
    main()
