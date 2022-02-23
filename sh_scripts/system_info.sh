#!/bin/bash
clear
echo "################################################"
echo "# Version: 0.1v                                #"
echo "#                                              #"
echo "#                System_Info                   #"
echo "#                    by                        #"
echo "#               johanneskr.de                  #"
echo "#                                              #"
echo "#                                              #"
echo "################################################"


print_info() {
    info title
    info underline

    info "OS" distro
    info "Host" model
    info "CPU" cpu
    info "Memory" memory
    info "Kernel" kernel
    info "Uptime" uptime
    info "Packages" packages
    info "Public IP" public_ip
