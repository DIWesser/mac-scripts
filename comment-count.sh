#! /bin/bash
# Counts number of lines of code that actually do something in a bash script

echo -ne "Enter the file to check: "
read file

# !!! BUG !!!
# Comments without whitespace following the `#` (e.g. `#foo`) are not matched
codeLines=$(grep -iw -v '^\s*#' $file | wc -l | xargs)
commentLines=$(grep -iw -e '^\s*#' $file | wc -l | xargs)
blankLines=$(grep -iw -e '^\s*$' $file | wc -l | xargs)
totalLines=$(wc -l $file | xargs | cut -d ' ' -f 1)

echo "Total length: $totalLines"
echo "Lines of code: $codeLines"
echo "Lines of comments: $commentLines"
echo "Blank lines: $blankLines"
