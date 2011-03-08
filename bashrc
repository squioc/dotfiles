if [ -f ~/.env ]; then
  . ~/.env
fi

if [ -f ~/.alias ]; then
  . ~/.alias
fi

if [ -f ~/.fun ]; then
  . ~/.fun
fi

for file in $(ls ~/.bash); do
  . ~/.bash/$file
done

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
