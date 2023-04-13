
#Replace with given string if string exists in file
replace_or_add_string() {
    local file="$1"
    shift 
    local string_to_replace="$1"
    shift
    local replacement_string="$1"

    # Check if the string to replace already exists in the file
    if grep -q "$string_to_replace" "$file"; then
        # If it exists, replace it with the replacement string
        sed -i "s/$string_to_replace/$replacement_string/g" "$file"
    else
        # If it doesn't exist, append the replacement string to the file
        echo "$replacement_string" >> "$file"
    fi
}

usage() {
	echo "usage: $0 file 'string to be replaced' 'replacement string'"
	echo "       $0 'test.txt' 'hello_world' 'replaced hello_world'"
	[ -z "$1" ] || exit "$1"
}

if ! [ $# -gt 0 ]; then
	usage 2 >&2
fi

# Call Method 
replace_or_add_string $1 $2 $3