#!/bin/bash

# Atualiza a lista de pacotes
sudo apt-get update

# Instala asdf - gerenciador de versões de runtime
sudo apt-get install curl git -y
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
source ~/.bashrc

# Instala asdf plugins para Node.js e PostgreSQL
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add postgres https://github.com/smashedtoatoms/asdf-postgres.git

# Instala uma versão específica do Node.js usando asdf
asdf install nodejs 18.18.0
asdf global nodejs 18.18.0

# Instala o PostgreSQL e suas dependências
sudo apt-get install postgresql postgresql-contrib -y

# Inicia o serviço do PostgreSQL e o configura para iniciar com o sistema
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Instala o PM2 globalmente
npm install pm2 -g

# Instala o Git
sudo apt-get install git -y

# Instala as dependências de compilação (build-essential)
sudo apt-get install build-essential -y
