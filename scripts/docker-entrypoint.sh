#!/bin/bash
cat << "EOF"
██╗     ██████╗  ██████╗ ███████╗██╗  ██╗
██║     ██╔══██╗██╔════╝ ██╔════╝╚██╗██╔╝
██║     ██████╔╝██║  ███╗█████╗   ╚███╔╝ 
██║     ██╔══██╗██║   ██║██╔══╝   ██╔██╗ 
███████╗██║  ██║╚██████╔╝███████╗██╔╝ ██╗
╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝ 
╔╗ ┌─┐┌─┐┬┌─┌─┐┬─┐┌─┐┌─┐┌─┐
╠╩╗├─┤│  ├┴┐├─┤├┬┘│ │└─┐├─┤
╚═╝┴ ┴└─┘┴ ┴┴ ┴┴└─└─┘└─┘┴ ┴    v0.1.0                                  
EOF
ln -snf /usr/share/zoneinfo/"${TZ}" /etc/localtime && echo "${TZ}" > /etc/timezone # Set timezone for ubuntu
env >> /etc/environment # This is needed for variables to be available to cron jobs or other programs
# set a trap to catch SIGTERM and SIGINT signals so we can exit gracefully
#exit the container when the script is finished
trap 'exit' SIGTERM SIGINT
if $signal == "done" ; then
    kill -s SIGTERM 1
fi
exec "$@" # This is needed to run other scripts or commands when running the container like docker run -it --rm backarosa:latest /bin/bash, backup,restore,container_start,container_stop ..etc
#so when you run the container it will run only one command from scripts folder and exit, however commands in line 3 and 4 will run on every docker run - mandatory hard coded - 