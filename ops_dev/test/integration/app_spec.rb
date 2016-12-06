# frozen_string_literal: true
require_relative 'spec_helper'

describe command("curl -f http://#{ENV['TARGET_HOST']}:#{ENV['TARGET_PORT']}") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(Regexp.new('^<h1>Ibotta DevOps Project</h1>')) }
end

describe command("curl -f http://#{ENV['TARGET_HOST']}:#{ENV['TARGET_PORT']}/tmpfile") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match Regexp.new('^<h1>Temporary File (.+?)</h1>') }
end

describe command("curl -f http://#{ENV['TARGET_HOST']}:#{ENV['TARGET_PORT']}/fortune") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match Regexp.new('^<h1>Fortune</h1>') }
end

describe command("curl -f http://#{ENV['TARGET_HOST']}:#{ENV['TARGET_PORT']}/mysql") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match Regexp.new('^<h1>MySQL Status</h1>') }
end
