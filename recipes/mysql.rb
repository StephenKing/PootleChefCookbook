#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

include_recipe "mysql::server"

mysql_database 't3o_pootle' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

template "/root/.my.cnf" do
  source "my.cnf.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
end