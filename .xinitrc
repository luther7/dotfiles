[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xmodmap .Xmodmap

exec i3
