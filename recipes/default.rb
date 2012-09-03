#
# Cookbook Name:: pootle
# Recipe:: default
#
# Copyright 2012, ttree ltd
#

include_recipe 'hostname'

include_recipe 'apt'

# Add dotdeb repository
apt_repository "dotdeb" do
  uri "http://ftp.hosteurope.de/mirror/packages.dotdeb.org/"
  distribution "squeeze"
  components ["all"]
  #key "http://www.dotdeb.org/dotdeb.gpg"
end

# Workaround: because enabling key on apt_repository don't work
execute "curl -s http://www.dotdeb.org/dotdeb.gpg | apt-key add -" do
  not_if "apt-key export 'Dotdeb'"
  notifies :run, "execute[apt-get update]"
end

bash "import dotdeb key" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    wget http://www.dotdeb.org/dotdeb.gpg
    cat dotdeb.gpg | apt-key add -
  EOH
  action :nothing
end

# Install required package
%w{openssl libssl-dev locales-all zip unzip libxslt1-dev libxslt1.1 swig}.each do |pkg|
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

# Install MySQL
include_recipe "pootle::mysql"

# Install Memcached
include_recipe 'memcached'

# Add user used by TER server
include_recipe "pootle::ter"

# Prepare webserver
include_recipe "pootle::webserver"

# Install Python
include_recipe "pootle::python"

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

