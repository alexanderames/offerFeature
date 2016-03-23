#!/usr/bin/env ruby

require 'json'
require_relative 'anagram_client'
require 'test/unit'

class TestCases < Test::Unit::TestCase

  def setup
    @helper = AnagramClient.new(ARGV)
  end

  def test_adding_words
    res = @helper.post('/words/new.json', nil, {"words" => ["read", "dear", "dare"] })

    assert_equal(200, res.code, "Unexpected response code")
  end

  def test_deleting_words
    pend # delete me
    # todo
  end

  def test_fetching_anagrams
    pend # delete me

    # add words to the dictionary
    @helper.post('/words/new.json', nil, {"words" => ["read", "dear", "dare"] })

    # fetch anagrams
    res = @helper.get('/anagrams/read.json')

    assert_equal(200, res.code, "Unexpected response code")
    assert_not_nil(res.body)

    body = JSON.parse(res.body)

    assert_not_nil(body['anagrams'])

    expected_anagrams = %w(dare dear)
    assert_equal(expected_anagrams, body['anagrams'].sort)
  end

  def test_fetching_anagrams_with_limit
    pend # delete me

    # add words to the dictionary
    @helper.post('/words/new.json', nil, {"words" => ["read", "dear", "dare"] })

    # fetch anagrams with limit
    res = @helper.get('/anagrams/read.json', 'limit=1')

    assert_equal(200, res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_not_nil(body['anagrams'])
  end

  def test_stats
    return
    # todo
  end

  def test_delete_and_stats
    return
    # todo
  end
end