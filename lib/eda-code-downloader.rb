require 'octokit'
require 'highline/import'

class EdaCodeDownloader < Struct.new(:organization, :branch_name_includes, :clone_location)
  def clone_repos
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

  private

  def repos
    @repos ||= fetch_paginated_repos
  end

  def fetch_paginated_repos
    next_repo_request = Octokit.org(organization).rels[:repos].get
    repos = next_repo_request.data

    until next_repo_request.rels[:next].nil?
      next_repo_request = next_repo_request.rels[:next].get
      repos.concat(next_repo_request.data)
    end

    repos
  end

  def clone_url(repo)
    repo.rels.to_hash[:ssh_url]
  end

  def clone_repo(repo, branch, clone_location)
    clone_job = fork do
      exec "cd #{clone_location} && git clone -b #{branch} --single-branch #{clone_url(repo)} &>/dev/null"
    end

    Process.detach(clone_job)
  end
end
