
# Changes to the given directory after running yazi with the given arguments.
#
# This is a wrapper around yazi that allows it to change directories. It
# does this by running yazi with the --cwd-file option and then changing
# directories to the given file. The temporary file is then removed.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}