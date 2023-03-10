
#Replace with given string if string exists in file
replace_or_add_string() {
    file="$1"
    string_to_replace="$2"
    replacement_string="$3"

    # Check if the string to replace already exists in the file
    if grep -q "$string_to_replace" "$file"; then
        # If it exists, replace it with the replacement string
        sed -i "s/$string_to_replace/$replacement_string/g" "$file"
    else
        # If it doesn't exist, append the replacement string to the file
        echo "$replacement_string" >> "$file"
    fi
}