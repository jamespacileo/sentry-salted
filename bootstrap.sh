sudo apt-get install git -y
wget -O - http://bootstrap.saltstack.org | sudo sh
mkdir /srv
cd /srv
git clone https://github.com/jamespacileo/sentry-salted.git
ln -s /srv/sentry-salted/states/salt /srv/salt
ln -s /srv/sentry-salted/states/pillar /srv/pillar
salt-call --local state.highstate