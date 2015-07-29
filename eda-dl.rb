#!/usr/bin/env ruby

require 'fileutils'

require 'octokit'
require 'highline/import'

def clone_url(repo)
  repo.rels.to_hash[:ssh_url]
end

def clone_repo(repo, branch, clone_location)
  clone_job = fork do
    exec "cd #{clone_location} && git clone -b #{branch} --single-branch #{clone_url(repo)} &>/dev/null"
  end

  Process.detach(clone_job)
end

def get_repos(organization)
  next_repo_request = Octokit.org(organization).rels[:repos].get
  repos = next_repo_request.data

  until next_repo_request.rels[:next].nil?
    next_repo_request = next_repo_request.rels[:next].get
    repos.concat(next_repo_request.data)
  end

  repos
end

def clone_repos(repos, branch_name_includes, clone_location)
  FileUtils::mkdir_p(clone_location) unless File.directory? clone_location

  repos.each do |repo|
    puts repo.name

    branch_to_clone = repo.rels[:branches].get.data.find { |branch| branch[:name].downcase.include? branch_name_includes }

    if branch_to_clone
      puts "Found branch: #{branch_to_clone[:name]}, cloning..."
      clone_repo(repo, branch_to_clone[:name], clone_location)
    end
  end
end

organization = ask("Github Organization to download from (e.g: kakapo-2015):  ")
username = ask("Github Username: ")
password = ask("Github Password/Personal Access Token (not stored): ") { |q| q.echo = '*' }
branch_name_includes = ask("What's your name? All branches containing this string will be cloned.").downcase

default_location_to_clone = "~/eda-repos/#{organization}"
location_to_clone = File.expand_path(ask("Where should I clone the repos to?") { |q| q.default = default_location_to_clone })

Octokit.configure do |c|
  c.login = username
  c.password = password
end

puts "Cloning repos from #{organization}...\n"

clone_repos(get_repos(organization), branch_name_includes, location_to_clone)
