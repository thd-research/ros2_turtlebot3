rosdep install --from-path src -yi --rosdistro humble

# install llama-cpp
python3 -m pip install --upgrade pip setuptools==70.1 wheel packaging
pip install llama-cpp-python --extra-index-url https://abetlen.github.io/llama-cpp-python/whl/cpu --verbose

apt remove python3-pyaudio

apt update
apt install -y portaudio19-dev python3-bluez alsa-utils
pip3 install --upgrade pyaudio


## Support alsa
ASOUNDRC="$HOME/.asoundrc"

cat > "$ASOUNDRC" <<'EOF'
pcm.!default {
    type null
}

ctl.!default {
    type hw
}
EOF

echo "Created $ASOUNDRC with dummy ALSA configuration."


## Py tree
apt install ros-humble-py-trees-ros-viewer -y

apt install libbluetooth-dev