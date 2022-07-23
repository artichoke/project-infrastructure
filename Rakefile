# frozen_string_literal: true

require 'open-uri'
require 'shellwords'
require 'bundler/audit/task'
require 'rubocop/rake_task'

TERRAFORM_ENVIRONMENTS = %w[
  aws
  github-org-artichoke
  github-org-artichokeruby
  github-org-artichoke-ruby
  remote-state
].freeze

task default: %i[format lint]

desc 'Lint sources'
task lint: %i[lint:rubocop:autocorrect lint:terraform]

namespace :lint do
  RuboCop::RakeTask.new(:rubocop)

  desc 'Lint Terraform sources'
  task :terraform do
    TERRAFORM_ENVIRONMENTS.each do |environment|
      sh "terraform -chdir=#{environment} validate"
    end
  end
end

desc 'Format sources'
task format: %i[format:terraform format:text]

namespace :format do
  desc 'Format Terraform sources with terraform fmt'
  task :terraform do
    sh 'terraform fmt -recursive'
  end

  desc 'Format text, YAML, and Markdown sources with prettier'
  task :text do
    sh 'npx prettier --write "**/*"'
  end
end

desc 'Format sources'
task fmt: %i[fmt:terraform fmt:text]

namespace :fmt do
  desc 'Format Terraform sources with terraform fmt'
  task :terraform do
    sh 'terraform fmt -recursive'
  end

  desc 'Format text, YAML, and Markdown sources with prettier'
  task :text do
    sh 'npx prettier --write "**/*"'
  end
end

Bundler::Audit::Task.new

namespace :terraform do
  desc 'Lock terraform providers on all plaforms in all environments'
  task :'providers:lock' do
    TERRAFORM_ENVIRONMENTS.each do |environment|
      sh "terraform -chdir=#{environment} providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=darwin_arm64 -platform=linux_amd64"
    end
  end
end

namespace :release do
  link_check_files = FileList.new('**/*.md') do |f|
    f.exclude('node_modules/**/*')
    f.exclude('**/target/**/*')
    f.exclude('**/vendor/**/*')
    f.include('*.md')
    f.include('**/vendor/*.md')
  end

  link_check_files.sort.uniq.each do |markdown|
    desc 'Check for broken links in markdown files'
    task markdown_link_check: markdown do
      command = ['npx', 'markdown-link-check', '--config', '.github/markdown-link-check.json', markdown]
      sh command.shelljoin
      sleep(rand(1..5))
    end
  end
end
