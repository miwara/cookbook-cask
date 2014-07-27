#
# Cookbook Name:: cookbook-cask
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# git "/home/vagrant/cask" do
#   repository "https://github.com/cask/cask.git"
#   reference "master"

#   user "vagrant"
#   group "vagrant"
# end

execute "install cask" do
  user "vagrant"
  group "vagrant"
  environment "HOME" => "/home/vagrant"

  cwd "/home/vagrant"
  command <<-EOH
  curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
  EOH

  not_if { File.exists?("/home/vagrant/.cask") }
end

# .emacs.d
directory "/home/vagrant/.emacs.d/" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

# Cask
template "/home/vagrant/.emacs.d/Cask" do
  source "Cask.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

execute "install emacs package" do
  user "vagrant"
  group "vagrant"
  environment "HOME" => "/home/vagrant"
  environment "PATH" => "/home/vagrant/.cask/bin:$PATH"

  cwd "/home/vagrant/.emacs.d"
  command <<-EOH
  cask upgrade-cask
  cask
  EOH
end
