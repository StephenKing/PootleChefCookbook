#
# Cookbook Name:: pootle
# Recipe:: default
#
# Copyright 2012, ttree ltd
#

# Update Apt package index
execute "update package index" do
  command "apt-get update"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install required package
%w{openssl libssl-dev locales-all zsh rubygems ruby ruby-dev postfix vim htop dstat zip unzip}.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe 'build-essential'

# Purge unused package
%w( portmap rpcbind nfs-common ).each {|p| package(p) { action :purge } }

include_recipe 'git'

# Add pootle user and group
user node['pootle']['pootle_user'] do
  action :create
  system true  
  home node['pootle']['pootle_homedir']
  manage_home true
  shell "/bin/zsh"
end

# Create home direction
directory node['pootle']['pootle_homedir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

# Add user used by TER server
include_recipe "pootle::ter"

# Prepare webserver
include_recipe "pootle::webserver"

# Install Python
include_recipe "pootle::python"

# Install Django
include_recipe "pootle::django"

# Install translation toolkits
include_recipe "pootle::translation_toolkit"

# Install MySQL
include_recipe "pootle::mysql"

# Install Memcached
include_recipe 'memcached'

# Install Pylucene
# Todo include_recipe "pootle::pylucene"

# Install ISO Codes
package "iso-codes"

# Deploy Pootle GIT repository
directory node['pootle']['pootle_root'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

execute "clone pootle repository" do
  command "git clone " + node['pootle']['pootle_git'] + " " + node['pootle']['pootle_root'] + " || cd " + node['pootle']['pootle_root'] + " && git pull"
  ignore_failure false
  action :nothing
end.run_action(:run)

template node['pootle']['pootle_root'] + "/localsettings.py" do
  source "localsettings.py.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

# Todo Deploy Pootle utility scripts

