# Nicer bash prompt
# if user is root, use red color, otherwise green
if [ "$(id -u)" -eq 0 ]; then
	USER_COLOR="\[\e[31m\]"
else
	USER_COLOR="\[\e[38;5;32m\]"
fi
export PS1="\[\e[31m\][\[\e[m\]${USER_COLOR}\u\[\e[m\]@\[\e[38;5;153m\]\H\[\e[m\] \[\e[38;5;74m\]\W\[\e[m\]\[\e[31m\]]\[\e[m\]\\$ "
