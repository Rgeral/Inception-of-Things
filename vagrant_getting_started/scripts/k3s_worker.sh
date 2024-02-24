#!/bin/bash

export TOKEN_FILE="/vagrant/scripts/node-token"
export K3S_INSTALL_OPTIONS="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip=$2"

echo "Exécution de l'agent..."
curl -sfL https://get.k3s.io | K3S_INSTALL_EXEC="$K3S_INSTALL_OPTIONS" sh -

echo "[SETUP] : Initialisation des alias pour tous les utilisateurs de la machine"
echo "alias k='kubectl'" | sudo tee /etc/profile.d/00-aliases.sh > /dev/null

echo "[machine : $(hostname)] a été configurée avec succès!"
