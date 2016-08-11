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
    @client.post('/words', nil, {"words" => ["read", "dear", "dare"] }) rescue nil
  end

  # runs after each test
  def teardown
    # delete everything
    @client.delete('/words') rescue nil
  end

  def test_adding_words
    res = @client.post('/words', nil, {"words" => ["read", "dear", "dare"] })

    assert_equal('201', res.code, "Unexpected response code")
  end

  def test_fetching_anagrams
    # fetch anagrams
    res = @client.get('/anagrams/read')

    assert_equal('200', res.code, "Unexpected response code")
    assert_not_nil(res.body)

    body = JSON.parse(res.body)

    assert_not_nil(body['anagrams'])

    expected_anagrams = %w(dare dear)
    assert_equal(expected_anagrams, body['anagrams'].sort)
  end

  def test_fetching_anagrams_with_limit
    # fetch anagrams with limit
    res = @client.get('/anagrams/read', 'limit=1')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(1, body['anagrams'].size)
  end

  def test_fetch_for_word_with_no_anagrams
    # fetch anagrams with limit
    res = @client.get('/anagrams/zyxwv')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(0, body['anagrams'].size)
  end

  def test_deleting_all_words
    res = @client.delete('/words')

    assert_equal('204', res.code, "Unexpected response code")

    # should fetch an empty body
    res = @client.get('/anagrams/read')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(0, body['anagrams'].size)
  end

  def test_deleting_all_words_multiple_times
    3.times do
      res = @client.delete('/words')

      assert_equal('204', res.code, "Unexpected response code")
    end

    # should fetch an empty body
    res = @client.get('/anagrams/read', 'limit=1')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(0, body['anagrams'].size)
  end

  def test_deleting_single_word
    # delete the word
    res = @client.delete('/words/dear')

    assert_equal('200', res.code, "Unexpected response code")

    # expect it not to show up in results
    res = @client.get('/anagrams/read')

    assert_equal('200', res.code, "Unexpected response code")

    body = JSON.parse(res.body)

    assert_equal(['dare'], body['anagrams'])
  end


# **Optional**
# - Endpoint that returns a count of words in the corpus and min/max/median/average word length
# - Respect a query param for whether or not to include proper nouns in the list of anagrams
# - Endpoint that identifies words with the most anagrams
# - Endpoint that takes a set of words and returns whether or not they are all anagrams of each other
# - Endpoint to return all anagram groups of size >= *x*
# - Endpoint to delete a word *and all of its anagrams*

# - Endpoint that returns a count of words in the corpus and min/max/median/average word length
  def test_word_stats
    res = @client.get('/stats')

    assert_equal('200', res.code, "Unexpected response code")

    stats = JSON.parse(res.body)['stats']

    assert_equal({
      "total_count" => 3,
      "min" => 4,
      "max" => 4,
      "median"=>4,
      "average" => 4,
      "weight" => 12,
      "word_length_hash" => {
        "4" => 3
      }
    }, stats)
  end

# - Respect a query param for whether or not to include proper nouns in the list of anagrams
  def test_proper_nouns
    # Taylor is word in the dictionary, so it is not a proper noun
    # aylort and loryat however are not so they are considered proper nouns
    @client.post('/words', nil, {"words" => ["taylor","aylort","loryat"] }) rescue nil

    res = @client.get('/anagrams/loryat',"properNoun=true")

    assert_equal('200', res.code, "Unexpected response code")
    assert_not_nil(res.body)

    body = JSON.parse(res.body)

    expected_anagrams = %w(aylort)
    assert_equal(expected_anagrams, body['anagrams'].sort)
  end
end