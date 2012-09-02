#
# Cookbook Name:: pootle
# Recipe:: ter
#
# Copyright 2012, ttree ltd
#

user node['pootle']['TER_l10n_user'] do
  action :create
  system true 
  home node['pootle']['TER_l10n_homedir']
  manage_home true
  shell "/bin/zsh"
end

# Create home direction
directory node['pootle']['TER_l10n_homedir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

# Prepare SSH configuration
directory node['pootle']['TER_l10n_homedir'] + "/.ssh" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

# Deploy authorized keys
template node['pootle']['TER_l10n_homedir'] + "/.ssh/authorized_keys" do
  source "ter.authorized_keys.txt.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end