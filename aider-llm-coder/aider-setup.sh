# install aider 
# See: https://aider.chat/docs/install.html
sudo apt install pipx
pipx install aider-install

# copy config file to user folder
cp .aider.conf.yml ~/.aider.conf.yml

# Install ollama
curl -fsSL https://ollama.com/install.sh | sh

# NOTE: Use efficient CPU-based models with mixture of experts.
ollama pull lfm2.5:latest

# Consider: `lfm2:latest` as a 14b model that's' very fast on CPU.
# https://ollama.com/library/lfm2

# Add the API base:
nano ~/.bashrc

# append to bottom of the file:
#export OLLAMA_API_BASE=http://127.0.0.1:11434

echo 'export OLLAMA_API_BASE=http://127.0.0.1:11434' >> ~/.bashrc
source ~/.bashrc
