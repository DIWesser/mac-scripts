#!/bin/bash
#
# Todo:
# - Integrate explain function.

# Save current year to variable
current_year="$(echo $(date +'%Y'))"

# Adds 3 to a given number
plus_three () {
    echo "$1 + 3" | bc -q
}

# Finds grad year
grad_year () {
    plus_three $current_year
}

# Formats grad year as answer and prints
give_answer () {
    echo "You will graduate by $(grad_year)."
}

# Describe how program works
explain () {
    echo "This program takes the current year and adds three years."
    echo "Using this formula, it has found that you will graduate in $(grad_year)"
}

main () {
    give_answer
}

main
