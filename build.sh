#!/bin/sh

if [ "x${1}" = "x" ];then
  echo "${0} <project-name>"
  exit 1
fi

if [ -f "$1" || -d "$1" ];then
  echo "${1} already exists"
  exit 1
fi

echo "Creating directories.."
mkdir -p ${1} ${1}/tmp ${1}/views ${1}/public ${1}/public/javascript ${1}/public/css ${1}/public/images

echo "Creating files.."
touch ${1}/app.rb ${1}/config.ru ${1}/Gemfile



cat <<EOT >${1}/Gemfile
# Gemfile
source :rubygems
 
 gem "sinatra"
 gem "haml"
EOT


cat <<EOT >${1}/config.ru
# config.ru
require "rubygems"
require "bundler/setup"
require "sinatra"
require "haml"
require "app"
 
 set :run, false
 set :raise_errors, true
  
  run Sinatra::Application
EOT



cat <<EOT >${1}/app.rb
# app.rb
set :haml, :format => :html5
 
 get "/" do
   haml :index
   end
EOT


cat <<EOT >${1}/views/index.haml
# views/index.haml
%html
  %head
    %title My title
      %body


echo "Creating bundle.."                 
cd $1
rvm all do bundle install

echo "run 'rackup' to start your app"
