require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Bump patch version'
task :patch do
  system 'gem bump --tag'
end

desc 'Bump minor version'
task :minor do
  system 'gem bump --version minor --tag'
end

desc 'Bump major version'
task :major do
  system 'gem bump --version major --tag'
end

task publish: [:build] do
  $VERBOSE = nil
  load 'jekyll_badge/version.rb'
  system "gem push pkg/jekyll_badge-#{JekyllBadge::VERSION}.gem"
end

desc 'Bump patch version, create git tag, build the gem and release to geminabox (default)'
task release_patch: %i[test patch publish]

desc 'Bump minor version, create git tag, build the gem and release to geminabox'
task release_minor: %i[test minor publish]

desc 'Bump major version, create git tag, build the gem and release to geminabox'
task release_major: %i[test major publish]

task default: :test
