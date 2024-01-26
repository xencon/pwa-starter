#!/bin/sh

# NVM
echo
echo "****** Installing Node Version Manager ******"
echo "****** https://github.com/nvm-sh/nvm ******"
echo
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="${HOME}/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"

# Node
echo
echo "****** Installing Node 18 ******"
echo
nvm install 18
