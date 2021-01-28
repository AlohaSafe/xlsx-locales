# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

loader = Zeitwerk::Loader.new
loader.push_dir(File.join(__FILE__, '../../app/models'))
loader.setup
loader.eager_load
