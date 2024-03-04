#!/bin/bash
#documentation https://docs.k3s.io/installation/configuration#configuration-with-install-script

export TOKEN_FILE="/vagrant/confs/node-token"
export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip=$2"

echo "Exécution de l'agent..."
curl -sfL https://get.k3s.io | sh -

echo 'export PATH="/sbin:$PATH"' >> /home/vagrant/.bashrc

source /home/vagrant/.bashrc

echo "[SETUP] : Initialisation des alias pour tous les utilisateurs de la machine"
echo "alias k='kubectl'" | sudo tee /etc/profile.d/00-aliases.sh > /dev/null

echo "[machine : $(hostname)] a été configurée avec succès!"