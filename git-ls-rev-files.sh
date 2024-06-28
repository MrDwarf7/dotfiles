#!/usr/bin/env bash
set -e

# Recursively list all files in the last 5 commits
revlist=$(git rev-list -5 HEAD)
(
	echo 'git files: '
	for rev in $revlist; do
		files=$(git log -1 --pretty="format:" --name-only $rev)
		echo "$(git log -1 --pretty="%s" $rev)"
		echo ""

		declare -A dir_tree

		for file in $files; do
			IFS='/'
			read -ra ADDR <<<"$file"
			path=""
			for part in "${ADDR[@]}"; do
				path="$path/$part"
				dir_tree["$path"]=1
			done
		done

		print_tree() {
			local prefix="$1"
			local level="${2:-0}"
			local indent=""
			for ((i = 0; i < level; i++)); do
				indent="$indent  "
			done
			for dir in "${!dir_tree[@]}"; do
				if [[ "$dir" == "$prefix"* ]] && [[ "$dir" != "$prefix" ]] && [[ "$(dirname "$dir")" == "$prefix" ]]; then
					echo "-$indent$(basename "$dir")"
					print_tree "$dir" $((level + 1))
				fi
			done
		}
		print_tree "/"
	done
) >___files_xml.txt

cat ___files_xml.txt

# non Recursively
# revlist=$(git rev-list -5 HEAD)
# {
# 	echo ""
# 	echo 'git files: '
# 	echo ""
# 	for rev in $revlist; do
# 		echo "$(git log -1 --pretty="%s" $rev)"
# 		files=$(git log -1 --pretty="format:" --name-only $rev)
# 		echo ""
#
# 		tempfile=$(mktemp)
#
# 		for file in $files; do
# 			IFS='/'
# 			read ra ADDR <<<"$file"
# 			path=""
# 			for part in "${ADDR[@]}"; do
# 				path="$path/$part"
# 				echo "$path" >>$tempfile
# 			done
# 		done
#
# 		sort -u "$tempfile" -o "$tempfile"
#
# 		# prev_indent_level=0
# 		prev_parts=()
# 		while IFS= read -r line; do
# 			[[ -z "$line" ]] && continue
# 			IFS='/' read -ra parts <<<"$line"
# 			indent_level=${#parts[@]}
#
# 			for ((i = 0; i < ${#parts[@]}; i++)); do
# 				indent=""
# 				for ((j = 0; j < i; j++)); do
# 					indent="$indent  "
# 				done
# 				echo "$indent${parts[$i]}"
# 			done
# 			prev_parts=("${parts[@]}")
# 		done <"$tempfile"
#
# 		rm "$tempfile"
# 	done
# } >___files_xml.txt
#
# cat ___files_xml.txt

# base line
# revlist=$(git rev-list -5 HEAD)
# (
# 	echo '<?xml version="1.0"?>'
# 	echo '<git>'
# 	for rev in $revlist; do
# 		files=$(git log -1 --pretty="format:" --name-only $rev)
# 		echo '    <commit>\n        <h1>\c'
# 		echo "$(git log -1 --pretty="%s" $rev)\c"
# 		echo '</h1>'
# 		for file in $files; do
# 			echo "        <list>$file</list>"
# 		done
# 		echo '    </commit>'
# 	done
# 	echo '</git>'
# ) >___files_xml.txt
