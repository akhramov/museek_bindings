require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/spec_helper.rb', 'spec/**/*_spec.rb']
  t.libs << 'spec'
end

task default: :test
