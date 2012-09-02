#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

venv_dir = node['pootle']['virtualenv_dir']

include_recipe 'python'

python_virtualenv venv_dir do
    interpreter "python"
    action :create
end

%w{python-software-properties python-lxml python-levenshtein python-memcache}.each do |pkg|
  package pkg do
    action :install
  end
end

# Install Django
python_pip "django" do
    version "1.3.3"
    action :install
    virtualenv venv_dir
end

# Install South
python_pip "south" do
    action :install
    virtualenv venv_dir
end

# Install Django Voting
python_pip "django-voting" do
    action :install
    virtualenv venv_dir
end

# Install Django Web Assets
python_pip "webassets" do
    action :install
    virtualenv venv_dir
end

# Install CSS min
python_pip "cssmin" do
    action :install
    virtualenv venv_dir
end