#! /usr/bin/env nix-shell
#! nix-shell -i ruby -p "ruby.withPackages (ps: with ps; [ git dotenv ])"

# frozen_string_literal: true

require 'dotenv'
require 'git'

def create_git_dir_and_sym
  target_folder = unless File.exist?(ARGV.first) then
                    ARGV.first
                  else
                    puts "directory already exists"
                    exit
                  end
  Dotenv.load '~/bin/builders/.env'
  top_level_git_dir = ENV['TOP_LEVEL_GIT_DIR']

  git_dir = File.join(top_level_git_dir, target_folder)
  Dir.mkdir(git_dir, 0o700)
  Git.init git_dir

  File.symlink(
    git_dir,
    File.join(Dir.pwd, target_folder)
  )
end

create_git_dir_and_sym
