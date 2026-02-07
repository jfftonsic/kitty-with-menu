set -euo pipefail

export http_proxy=${http_proxy:-http://proxy:8080}
export https_proxy=${https_proxy:-http://proxy:8080}
export HTTP_PROXY=${HTTP_PROXY:-http://proxy:8080}
export HTTPS_PROXY=${HTTPS_PROXY:-http://proxy:8080}

apt-get update
apt update

# Core build tooling + headers needed by kitty's setup.py checks.
#apt-get install -y \
#  build-essential \
#  pkg-config \
#  python3.12 \
#  python3.12-venv \
#  libxxhash-dev \
#  libharfbuzz-dev \
#  libfreetype6-dev \
#  libfontconfig1-dev \
#  libgl1-mesa-dev \
#  libx11-dev \
#  libxrandr-dev \
#  libxi-dev \
#  libxinerama-dev \
#  libxcursor-dev \
#  libwayland-dev \
#  wayland-protocols \
#  libdbus-1-dev \
#  liblcms2-dev \
#  libpng-dev \
#  libssl-dev libcairo2-dev libxkbcommon-dev libxkbcommon-x11-dev libx11-xcb-dev libsimde-dev
  

 apt-get install -y \
   build-essential pkg-config curl unzip fontconfig \
   python3.12 python3.12-venv \
   libxxhash-dev libharfbuzz-dev libfreetype-dev libfontconfig1-dev \
   libgl1-mesa-dev libx11-dev libx11-xcb-dev libxrandr-dev libxi-dev \
   libxinerama-dev libxcursor-dev libwayland-dev wayland-protocols \
   libdbus-1-dev liblcms2-dev libpng-dev libssl-dev libcairo2-dev \
   libxkbcommon-dev libxkbcommon-x11-dev libsimde-dev  

# Install Symbols Nerd Font (system-wide)
mkdir -p /usr/local/share/fonts/NerdFontsSymbolsOnly /tmp/nerdfonts
curl -fL --retry 5 --retry-delay 2 \
  -o /tmp/nerdfonts/NerdFontsSymbolsOnly.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
unzip -o /tmp/nerdfonts/NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts/NerdFontsSymbolsOnly


# update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 20
# update-alternatives --set python3 /usr/bin/python3.12


# Rebuild and verify font cache
fc-cache -fv
fc-list | grep -i "Symbols Nerd Font Mono" || true

# Ensure make uses system Python 3.12 (not pyenv shims)
export PATH=/usr/bin:/bin:$PATH
python3 --version
