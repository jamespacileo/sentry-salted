sudo apt-get install git
wget -O - http://bootstrap.saltstack.org | sudo sh
mkdir /srv/sentry-salted
cd /srv/sentry-salted
git clone git@github.com:jamespacileo/sentry-salted.git
ln -s /srv/sentry-salted/states/salt /srv/salt
ln -s /srv/sentry-salted/states/pillar /srv/pillar
salt-call --local state.highstate