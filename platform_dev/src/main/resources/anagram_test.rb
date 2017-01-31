#!/usr/bin/env ruby

require 'json'
require_relative 'anagram_client'
require 'test/unit'

# capture ARGV before TestUnit Autorunner clobbers it

class TestCases < Test::Unit::TestCase

  # runs before each test
  def setup
    @client = AnagramClient.new(ARGV)

    # add words to the dictionary
    @client.post('/words.json', nil, {"words" => ["read", "dear", "dare"] }) rescue nil
  end

  # runs after each test
  def teardown
    # delete everything
    @client.delete('/words.json') rescue nil
  end

  def test_adding_words
    res = @client.post('/words.json', nil, {"words" => ["read", "dear", "dare"] })

    assert_equal('201', res.code, "Unexpected response code")
  end

  def test_fetching_anagrams

    # fetch anagrams
    res = @client.get('/anagrams/read.json')

    assert_equal('200', res.code, "Unexpected response code")
    assert_not_nil(res.body)

    body = JSON.parse(res.body)

    assert_not_nil(body['anagrams'])

    expected_anagrams = %w(dare dear)
    assert_equal(expected_anagrams, body['anagrams'].sort)
  end

  def test_fetching_anagrams_with_limit

    # fetch anagrams with limit
    res = @client.get('/anagrams/read.json', 'limit=1')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(1, body['anagrams'].size)
  end

  def test_fetch_for_word_with_no_anagrams

    # fetch anagrams with limit
    res = @client.get('/anagrams/zyxwv.json')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(0, body['anagrams'].size)
  end

  def test_deleting_all_words

    res = @client.delete('/words.json')

    assert_equal('204', res.code, "Unexpected response code")

    # should fetch an empty body
    res = @client.get('/anagrams/read.json')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(0, body['anagrams'].size)
  end

  def test_deleting_all_words_multiple_times

    3.times do
      res = @client.delete('/words.json')

      assert_equal('204', res.code, "Unexpected response code")
    end

    # should fetch an empty body
    res = @client.get('/anagrams/read.json', 'limit=1')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(0, body['anagrams'].size)
  end

  def test_deleting_single_word

    # delete the word
    res = @client.delete('/words/dear.json')

    assert_equal('200', res.code, "Unexpected response code")

    # expect it not to show up in results
    res = @client.get('/anagrams/read.json')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(['dare'], body['anagrams'])
  end

  def test_anagram_group_size
    # read should be biggest result set with 3
    res = @client.get('/anagrams/groups/size/3')

    assert_equal('200', res.code, "Unexpected response code")

    arr = JSON.parse(res.body)

    assert_equal(1, arr.size)

    anagrams = arr[0]['anagrams']

    assert_equal(3, anagrams.size)

    # should also find when group size is smaller
    res = @client.get('/anagrams/groups/size/1')

    assert_equal('200', res.code, "Unexpected response code")

    arr = JSON.parse(res.body)

    assert_equal(1, arr.size)

    anagrams = arr[0]['anagrams']

    assert_equal(3, anagrams.size)

  end

  def test_delete_all_anagrams
    # should delete all 3 words
    res = @client.get('/anagrams/read.json')

    anagrams = JSON.parse(res.body)

    assert_equal(2, anagrams['anagrams'].size)

    # now delete
    res = @client.delete('/anagrams/read.json')

    assert_equal('200', res.code, "Unexpected response code")

    # fetch results again and check there are 0
    res = @client.get('/anagrams/read.json')

    anagrams = JSON.parse(res.body)

    assert_equal(0, anagrams['anagrams'].size)
  end

  def test_anagram_group_check
    # should check if the given words are anagrams
    res = @client.get('/anagrams/groups/isGroup?words=read,dear,dare')

    body = JSON.parse(res.body)

    assert_equal(true, body['isAnagramGroup'])
  end

end