#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

app_name = 'pootle'
app_config = node[app_name]

include_recipe "apache2"
include_recipe "apache2::mod_wsgi" 

# Set up the Apache virtual host 
web_app app_name do 
  server_name app_config['server_name']
  docroot app_config['docroot']
  pootle_root app_config['pootle_root']
  
  user app_config['pootle_user']
  group app_config['pootle_group']

  TER_l10n_root app_config['TER_l10n_root']

  template "#{app_name}.conf.erb" 

  log_dir node['apache']['log_dir'] 
end