#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

include_recipe 'python'

%w{python-software-properties python-lxml python-levenshtein python-memcache}.each do |pkg|
  package pkg do
    action :install
  end
end

# Install South
execute "pip install south" do
  command "pip install south"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install Django Voting
execute "pip install django-voting" do
  command "pip install django-voting"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install Django Web Assets
execute "pip install webassets" do
  command "pip install webassets"
  ignore_failure false
  action :nothing
end.run_action(:run)

# Install CSS min
execute "pip install cssmin" do
  command "pip install cssmin"
  ignore_failure false
  action :nothing
end.run_action(:run)