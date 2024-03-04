#!/bin/bash
#documentation https://docs.k3s.io/installation/configuration#configuration-with-install-script

echo "[K3S] : Installation en cours..."
export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1 --bind-address=$1 --advertise-address=$1"
curl -sfL https://get.k3s.io | sh -

echo "[K3S] : Copie du jeton du nœud maître vers (/vagrant/scripts/node-token)"
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/confs/

echo 'export PATH="/sbin:$PATH"' >> /home/vagrant/.bashrc

source /home/vagrant/.bashrc

echo "[SETUP] : Initialisation des alias pour tous les utilisateurs de la machine"
echo "alias k='kubectl'" | sudo tee /etc/profile.d/00-aliases.sh > /dev/null

echo "[Machine : $(hostname)] a été configurée avec succès!"
