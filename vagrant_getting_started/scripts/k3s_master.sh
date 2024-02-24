#!/bin/bash

echo "[K3S] : Installation en cours..."
export K3S_INSTALL_OPTIONS="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1 --bind-address=$1 --advertise-address=$1"
curl -sfL https://get.k3s.io | sh -

echo "[K3S] : Copie du jeton du nœud maître vers (/vagrant/scripts/node-token)"
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/scripts/

echo "[SETUP] : Initialisation des alias pour tous les utilisateurs de la machine"
echo "alias k='kubectl'" | sudo tee /etc/profile.d/00-aliases.sh > /dev/null

echo "[Machine : $(hostname)] a été configurée avec succès!"
