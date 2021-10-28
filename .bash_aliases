export AWS_WORK_DEV_ID='i-050cf58b8cb0dfd80'
export AWS_WORK_DEV_ID_CPU='i-02baca95e3e151c99'
get-instance-dns () {
    aws ec2 describe-instances --filters Name=instance-id,Values="$1" | jq .Reservations[0].Instances[0].PublicDnsName
}

get-instance-ip () {
    aws ec2 describe-instances --filters Name=instance-id,Values="$1" | jq -r .Reservations[0].Instances[0].PublicIpAddress
}

dev-up () {
    aws ec2 start-instances --instance-ids $AWS_WORK_DEV_ID
}
cpu-up () {
    aws ec2 start-instances --instance-ids $AWS_WORK_DEV_ID_CPU
}

dev-set () {
    export AWS_WORK_DEV_DNS=$(get-instance-dns $AWS_WORK_DEV_ID)
    export AWS_WORK_DEV_IP=$(get-instance-ip $AWS_WORK_DEV_ID)
    mv ~/.ssh/config ~/.ssh/config_backup
    cat ~/.ssh/base_config > ~/.ssh/config
    get-ssh-config dev $AWS_WORK_DEV_DNS ~/.ssh/peter.pem >> ~/.ssh/config
}
cpu-set () {
    export AWS_WORK_DEV_DNS_CPU=$(get-instance-dns $AWS_WORK_DEV_ID_CPU)
    export AWS_WORK_DEV_IP_CPU=$(get-instance-ip $AWS_WORK_DEV_ID_CPU)
    mv ~/.ssh/config ~/.ssh/config_backup
    cat ~/.ssh/base_config > ~/.ssh/config
    get-ssh-config cpu $AWS_WORK_DEV_DNS_CPU ~/.ssh/peter.pem >> ~/.ssh/config
}

get-ssh-config () {
echo "Host $1
    Hostname $2
    user ubuntu
    IdentityFile $3 
    Port 22
    ForwardAgent yes
"
}

dev-down() {
    aws ec2 stop-instances --instance-ids $AWS_WORK_DEV_ID
}
 
cpu-down() {
    aws ec2 stop-instances --instance-ids $AWS_WORK_DEV_ID_CPU
}

push-notebooks() {
    rsync -avL --progress --exclude=html --exclude=.ipynb_checkpoints --exclude=.DS_Store /home/peter/git/inca/notebooks/____aaaaaaaaSCRATCH dev:inca/notebooks/____aaaaaaaaSCRATCH
}

pull-notebooks() {
    rsync -avL --progress --exclude=html --exclude=.ipynb_checkpoints --exclude=.DS_Store dev:inca/notebooks/____aaaaaaaaSCRATCH /home/peter/git/inca/notebooks/____aaaaaaaaSCRATCH
}
push-notebooks-cpu() {
    rsync -avL --progress --exclude=html --exclude=.ipynb_checkpoints --exclude=.DS_Store /home/peter/git/inca/notebooks/____aaaaaaaaSCRATCH cpu:inca/notebooks/____aaaaaaaaSCRATCH
}

pull-notebooks-cpu() {
    rsync -avL --progress --exclude=html --exclude=.ipynb_checkpoints --exclude=.DS_Store cpu:inca/notebooks/____aaaaaaaaSCRATCH /home/peter/git/inca/notebooks/____aaaaaaaaSCRATCH
}

dev-ip() {
    echo $AWS_WORK_DEV_IP
}
cpu-ip() {
    echo $AWS_WORK_DEV_IP_CPU
}

alias vim="nvim"

alias jet="ssh crowd@192.168.0.180"
