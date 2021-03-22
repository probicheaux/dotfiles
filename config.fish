fish_vi_key_bindings
set -g theme_color_scheme nord
fenv source ~/.bashrc
fenv source ~/.bash_aliases
fenv source ~/.profile
set -x color_vi_mode_insert brgreen brgreen --bold
set PATH /usr/local/bin $PATH
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

