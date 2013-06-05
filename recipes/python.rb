#
# Cookbook Name:: pootle
# Recipe:: python
#
# Copyright 2012, ttree ltd
#

include_recipe 'python'

%w{
  python-software-properties
  python-lucene
  python-m2crypto
}.each do |pkg|
  package pkg
end

# Install Django
python_pip "django" do
  version "1.3.7"
end

# Install South
%w{
  south
  django-tastypie
  django-voting
  webassets
  django-assets
  cssmin
  lxml
  python-Levenshtein
  python-memcached
  translate-toolkit
  MySQL-python
}.each do |pgk|
  python_pip pkg
end
