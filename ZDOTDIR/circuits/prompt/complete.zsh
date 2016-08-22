#
# Loads prompt themes.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load and execute the prompt theming system.
autoload -Uz promptinit && promptinit

# Load the prompt theme.
zstyle -a ':delorean:circuit:prompt' theme 'prompt_argv'
if [[ "$TERM" == (dumb|linux|*bsd*) ]] || (( $#prompt_argv < 1 )); then
  prompt 'off'
else
  prompt "$prompt_argv[@]"
fi
unset prompt_argv

#
# Helpers.
#

# Decodes a unicode glyph into a script-safe representation.
alias glyph2hex='function { for g ($@) print -f "\\\x%s" $(printf $g | xxd -p -c1 -u) && print; }'
alias glyph2codepoint='function { for g ($@) print -n $g | iconv -f utf-8 -t UTF-32BE | xxd -p | sed -e "s/^0*/\\\U/"; }'

# Previews every possible color to see how it looks in the terminal.
alias colorlist='for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"'

# Previews plain/bold/highlight/bold+highlight in the terminal.
alias fontstyle='print -f "\e[0;31mplain\n\e[1;31mbold\n\e[0;91mhighlight\n\e[1;91mbold+highlight\n\e[0m"'
