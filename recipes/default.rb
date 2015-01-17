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

# .emacs.d
directory "/home/#{node['user']}/.emacs.d/" do
  owner node['user']
  group node['group']
  mode "0755"
  action :create
  not_if { File.exists?("/home/#{node['user']}/.emacs.d") }
end

# Cask
template "/home/#{node['user']}/.emacs.d/Cask" do
  source "Cask.erb"
  owner node['user']
  group node['group']
  mode "0644"

  not_if { File.exists?("/home/#{node['user']}/.emacs.d/Cask") }
end
