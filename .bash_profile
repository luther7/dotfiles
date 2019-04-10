
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval `ssh-agent -s`
    ssh-add
    ssh-add ~/.ssh/luther_aws.pem
fi
