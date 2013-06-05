#
# Cookbook Name:: pootle
# Recipe:: default
#
# Copyright 2012, ttree ltd
#

include_recipe 'hostname'
include_recipe 'apt'

# Add dotdeb repository
template "/etc/apt/sources.list.d/dotdeb.list" do
  owner "root"
  mode "0644"
  source "dotdeb.list.erb"
  notifies :run, resources("execute[apt-get update]"), :immediately
end
 
execute "curl -s http://www.dotdeb.org/dotdeb.gpg | apt-key add -" do
  not_if "apt-key export 'Dotdeb'"
end

execute "apt-get update" do
  action :nothing
end

# Install required package
%w{
  openssl
  libssl-dev
  locales-all
  zip
  unzip
  ruby1.9.1-full
  libxslt1-dev
  swig
  aspell
}.each do |pkg|

  r = package pkg do
    action :install
  end
  r.run_action(:install)
end

# Install Aspell dictionnary
execute "aptitude search aspell | awk '{print $2}' | grep ^aspell- | grep -v dictionary |  xargs apt-get -y install" do
  action :nothing
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

# Install MySQL
include_recipe "pootle::mysql"

# Install Memcached
include_recipe 'memcached'

service "memcached" do
  action :enable
end

# Install Python
include_recipe "pootle::python"

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

# Todo Set correct permissions in pootle directory

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

