var assert = require('assert');
var path = require('path');
describe('Dictionary', function() {
  /*
    Total Word Count
    Min
    Max
    Median
    Average Word Length
    -------------------
    total_count: int,
    min: int,
    max: int,
    median: int,
    average: int,
    word_length_hash[key: word_length, value: number_of_words]: {
        1: total_words,
        .
        .
    }
  */
  describe('__pushStats', function() {
    var __pushStats = require('./dictionary').__pushStats;
    var stats = {}

    beforeEach(function() {
      stats = {
        total_count: 0,
        min: null,
        median: null,
        average: null,
        weight: 0,
        word_length_hash: {}
      }
    })

    it('push hello should give total_count: 1, min: 5, median: 5, average: 5, weight: 5, word_length_hash:{5:1}', function() {
      __pushStats('hello', stats);
      assert.equal(stats.total_count, 1);
      assert.equal(stats.min, 5);
      assert.equal(stats.median, 5);
      assert.equal(stats.average, 5);
      assert.equal(stats.weight, 5);
      assert.equal(stats.word_length_hash[5], 1);
    })

    it('push hello, win should give total_count: 2, min: 3, median: 5, average: 4, weight: 8, word_length_hash:{5:1, 3:1}', function() {
      __pushStats('hello', stats);
      __pushStats('win', stats);
      assert.equal(stats.total_count, 2);
      assert.equal(stats.min, 3);
      assert.equal(stats.median, 5);
      assert.equal(stats.average, 4);
      assert.equal(stats.weight, 8);
      assert.equal(stats.word_length_hash[5], 1);
      assert.equal(stats.word_length_hash[3], 1);
    })

    it('push hello, win should give total_count: 3, min: 3, median: 5, average: 5, weight: 15, word_length_hash:{5:1,7:1,3:1}', function() {
      __pushStats('hello', stats);
      __pushStats('win', stats);
      __pushStats('awesome', stats)
      assert.equal(stats.total_count, 3);
      assert.equal(stats.min, 3);
      assert.equal(stats.median, 5);
      assert.equal(stats.average, 5);
      assert.equal(stats.weight, 15);
      assert.equal(stats.word_length_hash[5], 1);
      assert.equal(stats.word_length_hash[3], 1);
      assert.equal(stats.word_length_hash[7], 1);
    })
  })

  describe('__pushAnagram', function() {
    var __pushAnagram = require('./dictionary').__pushAnagram;
    var anagrams = {};

    it('"read", "dear", "dare", "wick", should form the object {"ader": [read, dear, dare], "cikw": [wick]}', function() {
      __pushAnagram("read", anagrams);
      __pushAnagram("dear", anagrams);
      __pushAnagram("dare", anagrams);
      __pushAnagram("wick", anagrams);
      assert.equal(anagrams['ader'].size, 3);
      assert.equal(anagrams['cikw'].size, 1);
    })
  })

  describe('__extractWord', function() {
    var __extractWord = require('./dictionary').__extractWord;

    it('word = hello, stringArray = ["world", "test0", "test1"] should return [helloworld, true]', function() {
      var testArray = ["world", "test0", "test1"];
      var result = __extractWord("hello", testArray);
      assert.equal(result[0],'helloworld');
      assert.equal(result[1],true);
      assert.equal(testArray.length, 2);
    });

    it('word = hello, stringArray = ["world", ""] should return [helloworld, true]', function() {
      var result = __extractWord("hello", ["world", ""]);
      assert.equal(result[0],'helloworld');
      assert.equal(result[1],true);
    });

    it('word = hello, stringArray = ["","world"] should return [hello, true]', function() {
      var result = __extractWord("hello", ["", "world"]);
      assert.equal(result[0],'hello');
      assert.equal(result[1],true);
    });

    it('word = hello, stringArray = ["","world",""] should return [hello, true]', function() {
      var result = __extractWord("hello", ["","world",""]);
      assert.equal(result[0],'hello');
      assert.equal(result[1],true);
    });

    it('word = hello, stringArray = ["world"] should return [helloworld, false]', function() {
      var result = __extractWord("hello", ["world"]);
      assert.equal(result[0],'helloworld');
      assert.equal(result[1],false);
    });
  });

  describe('dictionary', function() {
    var dictionary = null;

    beforeEach(function(done) {
      var file = path.join(__dirname,'..','..','resources','dictionary.txt');
      require('./dictionary').Dictionary(file).then(
        (_dictionary) => {
          dictionary = _dictionary;
          dictionary.pushWord('hello');
          dictionary.pushWord('lazy');
          dictionary.pushWord('exuberant');
          dictionary.pushWord('compile');
          dictionary.pushWord('dear');
          dictionary.pushWord('dare');
          dictionary.pushWord('read');
          // This is our name, taylor is a word in the dictionary
          dictionary.pushWord('Tayter');
          dictionary.pushWord('murder');
          dictionary.pushWord('redrum');
          done();
        },
        (error) => {
          done(error);
        }
      )
    })

    it('getAnagram dear should return [dare, read]', function() {
      var anagrams = dictionary.getAnagram('dear');
      assert.equal(anagrams.length, 2);
      assert.equal(anagrams[0], 'dare');
      assert.equal(anagrams[1], 'read');

      anagrams = dictionary.getAnagram('daer');
      assert.equal(anagrams.length, 0);

      anagrams = dictionary.getAnagram('dear', true);
      assert.equal(anagrams.length, 0);

      anagrams = dictionary.getAnagram('tAyter', true);
      assert.equal(anagrams.length, 0);
    })

    it('deleteWord dear should return [dare, read]', function() {
      dictionary.deleteWord('dear');
      
      var anagrams = dictionary.getAnagram('dear');
      assert.equal(anagrams.length, 0);

      anagrams = dictionary.getAnagram('dare');
      assert.equal(anagrams.length, 1);
      assert.equal(anagrams[0], 'read');
    })

    it('deleteWords', function() {
      dictionary.deleteWords(['redrum','dare','yep','tayter']);

      var anagrams = dictionary.getAnagram('murder');
      assert.equal(anagrams.length, 0);

      anagrams = dictionary.getAnagram('yep');
      assert.equal(anagrams.length, 0);

      anagrams = dictionary.getAnagram('read');
      assert.equal(anagrams.length, 1);
      assert.equal(anagrams[0], 'dear');

      anagrams = dictionary.getAnagram('tayter');
      assert.equal(anagrams.length, 0);
    })

    it('getStats', function() {
      var stats = dictionary.getStats();
      assert.equal(stats.total_count, 10);
      assert.equal(stats.min, 4);
      assert.equal(stats.median, 6);
      assert.equal(stats.average, 5);
      assert.equal(stats.weight, 55);
      assert.equal(stats.word_length_hash[4], 4);

      dictionary.deleteWords(['read','dear'])

      var stats = dictionary.getStats();
      assert.equal(stats.total_count, 8);
      assert.equal(stats.min, 4);
      assert.equal(stats.median, 6);
      assert.equal(stats.average, 5);
      assert.equal(stats.weight, 47);
      assert.equal(stats.word_length_hash[4], 2);
    })
  })
});