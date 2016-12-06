# frozen_string_literal: true
require_relative 'test_helper'

describe 'The app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'renders markdown as HTML' do
    get '/'
    assert last_response.ok?
    assert_match Regexp.new('^<h1>Ibotta DevOps Project</h1>'), last_response.body
  end

  it 'reads and writes a temporary file' do
    get '/tmpfile'
    assert last_response.ok?
    assert_match Regexp.new('^<h1>Temporary File (.+?)</h1>'), last_response.body
  end

  it 'displays a fortune' do
    get '/fortune'
    assert last_response.ok?
    assert_match Regexp.new('^<h1>Fortune</h1>'), last_response.body
  end

  it 'connects to a local MySQL server' do
    get '/mysql'
    assert last_response.ok?
    assert_match Regexp.new('^<h1>MySQL Status</h1>'), last_response.body
  end
end
