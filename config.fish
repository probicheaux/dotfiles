fish_vi_key_bindings
set -g theme_color_scheme nord
set -g theme_newline_cursor yes
set -g theme_newline_prompt '======> '
set -g EDITOR 'nvim'
fenv source ~/.bashrc
fenv source ~/.bash_aliases
fenv source ~/.profile
set -x color_vi_mode_insert brgreen brgreen --bold
set PATH /usr/local/bin $PATH
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

status is-login; and pyenv init --path | source
pyenv init - | source
set fish_user_paths (npm bin -g)

alias k=kubectl
alias eks-prod="aws eks update-kubeconfig --name core-production"
alias eks-eq="aws eks update-kubeconfig --name experiment-queue"

alias gamer="cd ~/games"
alias work="cd ~/git/inca"
alias temp="cd ~/git/temp"
alias tmpy="nvim ~/git/temp/py/temp.py && python ~/git/temp/py/temp.py"
alias aconf="nvim ~/.config/alacritty/alacritty.yml"
alias vconf="nvim ~/.config/nvim/init.vim"
alias fconf="nvim ~/.config/fish/config.fish"


thefuck --alias | source
