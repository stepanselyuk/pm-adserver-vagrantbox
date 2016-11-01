#!/usr/bin/env bash

cd ~/install

yum -y install http://mirror.symnds.com/distributions/gf/el/7/gf/x86_64/gf-release-7-10.gf.el7.noarch.rpm
yum -y --enablerepo=gf-plus install git-all
