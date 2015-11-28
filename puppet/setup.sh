#!/bin/bash
#
# Usage: ./puppet.sh version environment[production|acceptance|development]
# Install puppet
# With a pinned version
# on acceptance, development or production


set -e


# Working directory
WD=/opt


ENVIRONMENT="$1"
if [ -z "$ENVIRONMENT" ] ; then
    ENVIRONMENT="development"
fi
echo "Environment set to ${ENVIRONMENT}"


function main {


    if [ ! -d $WD ] ; then
      mkdir -p $WD
    fi
    cd $WD


    # We will only update and install in the first provisioning step.
    # If ever you need to update again
    FIRSTRUN=$WD/firstrun
    if [ -f $FIRSTRUN ] ; then
        echo "Already installed. To reinstall or update, remove this file ${FIRSTRUN}"
        exit 0
    fi

    puppet_conf=/etc/puppet/puppet.conf


    echo "deb http://apt.puppetlabs.com/ precise main
    deb-src http://apt.puppetlabs.com/ precise main">/etc/apt/sources.list.d/puppet.list

    wget -O /tmp/pubkey.gpg http://apt.puppetlabs.com/pubkey.gpg
    gpg --import /tmp/pubkey.gpg
    gpg -a --export 4BD6EC30 | apt-key add -
    apt-get -y update
    if [ -f $puppet_conf ] ; then
        rm $puppet_conf
    fi
    apt-get -y install facter puppet-common=3.8.3-1puppetlabs1
    apt-mark hold puppet-common


    echo "[main]
environment=${ENVIRONMENT}
factpath=/lib/facter
logdir=/var/log/puppet
rundir=/var/run/puppet
ssldir=/var/lib/puppet/ssl
vardir=/var/lib/puppet

[agent]
report=false


[master]
# These are needed when the puppetmaster is run by passenger
# and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN
ssl_client_verify_header = SSL_CLIENT_VERIFY" > $puppet_conf


    puppet agent --enable


    # install our dependencies
    puppet module install amosjwood-neo4j
    puppet module install arioch-redis
    puppet module install elasticsearch-elasticsearch
    puppet module install maestrodev-wget
    puppet module install puppetlabs-java
    puppet module install puppet-nodejs

    touch $FIRSTRUN

    set +e

    # On of these two commands is allowed to fail.
    apt-get -y update
    yum -y update

    puppet apply /etc/puppet/manifests/sites.pp

    echo "I think we are done for today."

    exit 0
}


main


