export AWS_WORK_DEV_ID='i-050cf58b8cb0dfd80'
get-instance-dns () {
    aws ec2 describe-instances --filters Name=instance-id,Values="$1" | jq .Reservations[0].Instances[0].PublicDnsName
}

get-instance-ip () {
    aws ec2 describe-instances --filters Name=instance-id,Values="$1" | jq -r .Reservations[0].Instances[0].PublicIpAddress
}

dev-up () {
    aws ec2 start-instances --instance-ids $AWS_WORK_DEV_ID
}

dev-set () {
    export AWS_WORK_DEV_DNS=$(get-instance-dns $AWS_WORK_DEV_ID)
    export AWS_WORK_DEV_IP=$(get-instance-ip $AWS_WORK_DEV_ID)
    mv ~/.ssh/config ~/.ssh/config_backup
    cat ~/.ssh/base_config > ~/.ssh/config
    get-ssh-config dev $AWS_WORK_DEV_DNS >> ~/.ssh/config
}

get-ssh-config () {
echo "Host $1
    Hostname $2
    user ubuntu
    IdentityFile ~/.ssh/crowdai_ed25519
    Port 22
    ForwardAgent yes
"
}

dev-down() {
    aws ec2 stop-instances --instance-ids $AWS_WORK_DEV_ID
}

push-notebooks() {
    rsync -avL --progress --exclude=html --exclude=.ipynb_checkpoints --exclude=.DS_Store /home/peter/git/inca/notebooks dev:inca/notebooks
}

pull-notebooks() {
    rsync -avL --progress --exclude=html --exclude=.ipynb_checkpoints --exclude=.DS_Store dev:inca/notebooks /home/peter/git/inca/notebooks
}

dev-ip() {
    echo $AWS_WORK_DEV_IP
}

alias vim="nvim"

