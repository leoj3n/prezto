#
# Executes commands at logout.
#

# Say farewell (if STDIN and STDOUT are TTY).
if [[ -t 0 && -t 1 ]]; then
  cat <<-EOF
SEE YOU IN THE FUTURE!

EOF
fi
