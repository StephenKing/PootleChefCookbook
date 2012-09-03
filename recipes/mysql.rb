#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

include_recipe "mysql::server"

execute "gem install mysql" do
  command "gem install mysql"
  ignore_failure false
  action :nothing
end.run_action(:run)

mysql_database 't3o_pootle' do
  connection mysql_connection_info
  encoding "utf8"
  action :create
end

mysql_database_user node['pootle']['db_user'] do
  connection mysql_connection_info
  password node['pootle']['db_password']
  database_name node['pootle']['db_name']
  privileges [:select,:update,:insert,:delete,:create,:alter]
  action :grant
end

template "/root/.my.cnf" do
  source "my.cnf.erb"
  owner "root"
  group "root"
  mode "0600"
  action :create
end