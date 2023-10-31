#!/usr/bin/env zsh

YELLOW='%F{yellow}'
GREEN='%F{green}'
NC='%f'
filename="./build/mapping.txt"
count=0

while read -r line; do
	if [ "${line:0:1}" = "#" ]; then
		name_num=(${(@s/:/)line})
		print -Pn "\n${YELLOW}${name_num[1]:1} (${name_num[2]} glyphs)${NC}:"
		echo
		count=$((count + name_num[2]))
	else
		str=""
		IFS=';' read -rA array_glyph <<<"$line"
		for glyph in "${array_glyph[@]}"; do
			info=(${(@s/:/)glyph})
			if [ $# -gt 0 ]; then
				str="$str${info[1]}: \u${info[2]}\n"
			else
				str="$str \u${info[2]}"
			fi
		done
		print -Pn $str | sed 's/ /  /g'
		echo
	fi
done <"$filename"

print -Pn "\n${GREEN}Total: $count glyphes${NC}"
echo
