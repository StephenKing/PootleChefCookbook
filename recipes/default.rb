#
# Cookbook Name:: pootle
# Recipe:: default
#
# Copyright 2012, ttree ltd
#

# Install required package
include_recipe 'apt'
%w{openssl libssl-dev locales-all zip unzip}.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe 'build-essential'
include_recipe 'git'

# Add pootle user and group
user node['pootle']['pootle_user'] do
  system true  
  home node['pootle']['pootle_homedir']
  manage_home false
end

# Create home direction
directory node['pootle']['pootle_homedir'] do
  mode "0755"
  recursive true
end

# Add user used by TER server
include_recipe "pootle::ter"

# Prepare webserver
include_recipe "pootle::webserver"

# Install Python
include_recipe "pootle::python"

# Install mysql python
include_recipe "pootle::mysql-python"

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
  mode "0755"
  recursive true
end

git "pootle" do
  repository node['pootle']['pootle_git']
  destination node['pootle']['pootle_root']
  reference "master"
end

directory node['pootle']['pootle_po_root'] do
  owner "pootle"
  group "pootle"
  mode "0755"
  recursive true
end

template node['pootle']['pootle_root'] + "/localsettings.py" do
  notifies :reload, "service[apache2]"
  source "localsettings.py.erb"
  mode "0644"
end

# Todo Deploy Pootle utility scripts

