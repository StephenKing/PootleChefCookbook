#
# Cookbook Name:: pootle
# Recipe:: webserver
#
# Copyright 2012, ttree ltd
#

include_recipe 'python'

%w{python-software-properties}.each do |pkg|
  package pkg do
    action :install
  end
end

# Install Django
python_pip "django" do
    version "1.3.3"
    action :install
end

# Install South
python_pip "south" do
    action :install
end

# Install Django Voting
python_pip "django-voting" do
    action :install
end

# Install Django Web Assets
python_pip "webassets" do
    action :install
end

# Install CSS min
python_pip "cssmin" do
    action :install
end

# Install Lxml
python_pip "lxml" do
    action :install
end

# Install Levenshtein
python_pip "python-Levenshtein" do
    action :install
end

# Install Levenshtein
python_pip "python-memcached" do
    action :install
end

# Install Levenshtein
python_pip "translate-toolkit" do
    action :install
end

# Install MySQL Python
python_pip "MySQL-python" do
    action :install
end

# Install M2Crypto
python_pip "M2Crypto" do
    action :install
end