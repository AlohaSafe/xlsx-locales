# frozen_string_literal: true

guard :rspec, cmd: 'bundle exec rspec' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # watch(/.+\.rb$/) { |m| puts "spec/models/#{m[1]}_spec.rb"; rspec.spec_dir }
  watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }

  # Ruby files
  # ruby = dsl.ruby
  # dsl.watch_spec_files_for(ruby.lib_files)
end

guard :rubocop, cli: ['--auto-correct', '--display-cop-names'] do
  ignore(/_tmp_/)
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
