#
# Cookbook Name:: pootle
# Recipe:: ter
#
# Copyright 2012, ttree ltd
#

user node['pootle']['TER_l10n_user'] do
  system true 
  home node['pootle']['TER_l10n_homedir']
  manage_home false
end

# Create home direction
directory node['pootle']['TER_l10n_homedir'] do
  owner node['pootle']['TER_l10n_user']
  mode "0755"
  recursive true
end

# Prepare SSH configuration
directory node['pootle']['TER_l10n_homedir'] + "/.ssh" do
  node['pootle']['TER_l10n_user']
  mode "0755"
  recursive true
end

# Deploy authorized keys
template node['pootle']['TER_l10n_homedir'] + "/.ssh/authorized_keys" do
  owner  node['pootle']['TER_l10n_user']
  source "ter.authorized_keys.txt.erb"
  mode "0644"
end
