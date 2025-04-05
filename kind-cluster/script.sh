#!/bin/bash

ARCH=$(uname -m)

# Download kind based on architecture
if [ "$ARCH" = "x86_64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
elif [ "$ARCH" = "aarch64" ]; then
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Download kubectl based on architecture
VERSION="v1.30.0"
if [ "$ARCH" = "x86_64" ]; then
    URL="https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
elif [ "$ARCH" = "aarch64" ]; then
    URL="https://dl.k8s.io/release/${VERSION}/bin/linux/arm64/kubectl"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

curl -LO "$URL"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client

# Clean up
rm -f kubectl
rm -rf kind

echo "kind & kubectl installation complete."

