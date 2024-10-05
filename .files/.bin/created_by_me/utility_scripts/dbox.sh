#!/bin/bash

configure_docker(){
	  echo "sudo systemctl enable --now docker"
      sudo systemctl enable --now docker
      echo "sudo systemctl start docker"
      sudo systemctl start docker
      echo "sudo systemctl enable docker"
      sudo systemctl enable docker
      echo "sudo usermod -aG docker $USER"
      sudo usermod -aG docker $USER
      echo "sudo chgrp docker /usr/bin/docker"
      sudo chgrp docker /usr/bin/docker
      echo "sudo chgrp docker /var/run/docker.sock"
      sudo chgrp docker /var/run/docker.sock
      cmd0="ls $(which docker)"
      echo $cmd0
      $cmd0
      cmd="ls /var/run/docker.sock"
      echo $cmd
      $cmd
      echo "systemctl enable docker"
      systemctl enable docker
      # https://unix.stackexchange.com/questions/252684/why-am-i-getting-cannot-connect-to-the-docker-daemon-when-the-daemon-is-runnin

      echo "export DOCKER_HOST=unix:///var/run/docker.sock"  >>~/.zshrc
echo "instalamos coder"
curl -L https://coder.com/install.sh | sh

echo "verificamos instalacion de coder"
which coder

echo "################################################################"
echo ""
echo "Provision local/remote development environments via Terraform"
echo ""
echo "Recuerda instalar las extenciones y autenticarte via vscode"
echo ""
echo ""
echo "      # iniciamos el servidor http://127.0.0.1:3000/"
echo "        coder server"
echo ""
echo "      # autenticammos la CLI"
echo "        coder login"
echo ""
echo "      # conectarse via ssh desde la terminal"
echo "        coder config-ssh"
echo ""
echo "      # <>first> es a donde nos vamos a conectar"
echo "        ssh coder.First"
echo ""
echo ""
echo "      # <>first> es el workspace"
echo "        coder start First"
echo "        coder stop First"
echo ""
echo "################################################################"

 # iniciamos el servidor
# coder server

# # autenticammos la CLI
# coder login

# # conectarse via ssh desde la terminal
# coder config-ssh



      sleep 2
      gum style --foreground 35 "reboot your machine to complete installation!"
      echo ""

}
