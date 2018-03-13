wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install elixir esl-erlang -y

# Memastikan UTF8 sebagai native name encoding
sudo update-locale LC_ALL=en_US.UTF-8
yes | mix local.hex

yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez

sudo apt-get install inotify-tools -y


