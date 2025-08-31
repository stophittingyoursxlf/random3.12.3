#!/bin/bash

set -e

echo "Устанавливаем pyenv и Python 3.12.3..."

echo "Устанавливаем зависимости..."
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git

if [ ! -d "$HOME/.pyenv" ]; then
    echo "Устанавливаем pyenv..."
    curl -fsSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
else
    echo "pyenv уже установлен"
fi

if ! grep -q "pyenv" ~/.bashrc; then
    echo "Настраиваем PATH..."
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
fi

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

if ! command -v pyenv &> /dev/null; then
    echo "pyenv не доступен. Пробуем обновить сессию..."
    source ~/.bashrc
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi

echo "Устанавливаем Python 3.12.3..."
pyenv install 3.12.3 -s

echo "Устанавливаем как версию по умолчанию..."
pyenv global 3.12.3

echo "Проверяем установку..."
python --version
pip --version
