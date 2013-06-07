#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

include_recipe "build-essential"
include_recipe "java"

# openjdk-7-jdk

%w{
g++
python-dev
jcc
ant
subversion
}.each do |pkg|
  package pkg do
    action :install
  end
end

ark "pylucene" do
  path "/usr/local/src/"
  # make this an attribute
  url "http://apache.mirror.testserver.li//lucene/pylucene/pylucene-2.9.4-1-src.tar.gz"
  action :put
end

subversion "pylucene-jcc" do
  repository "http://svn.apache.org/repos/asf/lucene/pylucene/trunk/jcc"
  destination "/usr/local/src/jcc"
  action :checkout
#  notifies :run, "execute[patch-package-distribute]", :immediately
  notifies :run, "execute[jcc-setup-build]", :immediately
  notifies :run, "execute[jcc-setup-install]", :immediately
end

# ouch.. that's very bad... is there no way around?
#execute "patch-package-distribute" do
#  command "patch -d /usr/local/lib/python2.6/dist-packages/distribute-0.6.28-py2.6.egg -Nup0 < /usr/local/src/jcc/jcc/patches/patch.43.0.6c7"
#  action :nothing
#end

execute "jcc-setup-build" do
  command "python setup.py build"
  cwd "/usr/local/src/jcc"
  # environment({ "JCC_JDK" => "/usr/lib/jvm/java-7-openjdk-amd64" })
  environment({ "JCC_JDK" => node[:java][:java_home] })
  action :nothing
end

execute "jcc-setup-install" do
  command "python setup.py install"
  cwd "/usr/local/src/jcc"
  # environment({ "JCC_JDK" => "/usr/lib/jvm/java-7-openjdk-amd64" })
  environment({ "JCC_JDK" => node[:java][:java_home] })
  action :nothing
end
