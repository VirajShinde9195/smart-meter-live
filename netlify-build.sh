#!/usr/bin/env bash
set -e

# Download Flutter
if [ ! -d "$HOME/flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
fi

export PATH="$HOME/flutter/bin:$PATH"

# Enable web
flutter config --enable-web
flutter precache --web

# Get packages
flutter pub get

# Build web
flutter build web --release
