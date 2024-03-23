#!/bin/bash
# Documentation : https://docs.k3s.io/installation/configuration#configuration-with-install-script

# Installation de K3S
echo "[K3S] : Installation en cours..."
export INSTALL_K3S_EXEC="--write-kubeconfig-mode=644 --tls-san $(hostname) --node-ip $1 --bind-address=$1 --advertise-address=$1"
if curl -sfL https://get.k3s.io | sh - > /dev/null; then
    echo "[K3S] : Installation terminée avec succès"
else
    echo "[K3S] : Erreur lors de l'installation de K3S" >&2
    exit 1
fi

# Copie du jeton du nœud maître
echo "[K3S] : Copie du jeton du nœud maître vers (/vagrant/scripts/node-token)"
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/confs/

# Installation des applications

install_app() {
    local app_name="$1"
    local configmap_name="${app_name//-/_}"-html
    local app_yaml="/vagrant/confs/${app_name}/${app_name}.yaml"

    echo "[$app_name] : Installation de l'application $app_name..."
    if sudo kubectl create configmap "$configmap_name" --from-file "/vagrant/confs/${app_name}/index.html" > /dev/null && \
        sudo /usr/local/bin/kubectl apply -f "$app_yaml" > /dev/null; then
        echo "[$app_name] : Succès"
    else
        echo "[$app_name] : Erreur lors de l'installation de l'application $app_name" >&2
    fi
}

install_app "app1"
install_app "app2"
install_app "app3"

# Configuration de la machine
echo 'export PATH="/sbin:$PATH"' >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

echo "[SETUP] : Initialisation des alias pour tous les utilisateurs de la machine"
echo "alias k='kubectl'" | sudo tee /etc/profile.d/00-aliases.sh > /dev/null

echo "[Machine : $(hostname)] a été configurée avec succès!"
