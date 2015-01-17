#
# Cookbook Name:: cookbook-cask
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "install cask" do
  user node['user']
  group node['group']
  environment "HOME" => "/home/#{node['user']}"

  cwd "/home/#{node['user']}"
  command <<-EOH
  curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
  EOH

  not_if { File.exists?("/home/#{node['user']}/.cask") }
end
