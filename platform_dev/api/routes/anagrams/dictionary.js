var fs = require('fs')

// Returns
// [concantenatedWord, (True: End of word, False: Continue)]
var extractWord = function (word, stringArray) {
  var next = stringArray.splice(0,1)[0];
  if (next.length === 0)
    return [word, true];
  if (stringArray.length > 0)
    return [word + next, true]  
  return [word + next, false]
}

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
  weight: int,
  word_length_hash[key: word_length, value: number_of_words]: {
      1: total_words,
      .
      .
  }
*/
var pushStats = function (word, stats) {
  var length = word.length;
  stats.total_count ++;
  stats.word_length_hash[length] = stats.word_length_hash[length] ? stats.word_length_hash[length] + 1 : 1;
  stats.min = stats.min && length > stats.min ? stats.min : length;
  stats.max = stats.max && length > stats.max ? stats.max : length;
  // Allows us to recalculate the averate O(1) complexity
  stats.weight += length;
  stats.average = Math.floor(stats.weight / stats.total_count);

  // Get our median word length
  if (stats.median) {
    var keys = Object.keys(stats.word_length_hash);

    // Convert our keys to numbers sort them in order
    keys = keys.map(Number).sort();
    var total = 0;
    for (var i = 0; i < keys.length; i ++) {
      var key = keys[i];
      total += stats.word_length_hash[key] * key;
      if (Math.floor(total / 2) > stats.total_count) {
        stats.median = key;
        break;
      }
    }
  } else {
    stats.median = length;
  }

}

var recomputeStats = function(word, stats) {
  var length = word.length;
  stats.total_count --;
  stats.word_length_hash[length]--;
  if (stats.word_length_hash[length] === 0)
    delete stats.word_length_hash[length];

  var keys = Object.keys(stats.word_length_hash);
    keys = keys.map(Number).sort();

  if (keys.length > 0) {

    stats.weight -= length;
    stats.average = Math.floor(stats.weight / stats.total_count);

    if (keys.length === 1) {
      stats.min = keys[0]
    } else {
      stats.min = keys[0]
      stats.max = keys[keys.length - 1]
    }
    
    var total = 0;
    for (var i = 0; i < keys.length; i ++) {
      var key = keys[i];
      total += stats.word_length_hash[key] * key;
      if (Math.floor(total / 2) > stats.total_count) {
        stats.median = key;
        break;
      }
    }
  } else {
    stats.total_count = 0;
    stats.min = null;
    stats.median = null;
    stats.average = null;
    stats.weight = 0;
    stats.word_length_hash = {};
  }
}

var pushAnagram = function (word, anagrams) {
  var sortedKey = word.split('').sort().join('');
  if (anagrams[sortedKey]) {
    anagrams[sortedKey].add(word);
  } else {
    anagrams[sortedKey] = new Set()
    anagrams[sortedKey].add(word)
  }
}

// The API you design should respond on the following endpoints as specified.

// POST /words.json: Takes a JSON array of English-language words and adds them to the corpus (data store).
// GET /anagrams/:word.json:
// Returns a JSON array of English-language words that are anagrams of the word passed in the URL.
// This endpoint should support an optional query param that indicates the maximum number of results to return.
// DELETE /words/:word.json: Deletes a single word from the data store.
// DELETE /words.json: Deletes all contents of the data store.
// Optional

// Endpoint that returns a count of words in the corpus and min/max/median/average word length
// Respect a query param for whether or not to include proper nouns in the list of anagrams
// Endpoint that identifies words with the most anagrams
// Endpoint that takes a set of words and returns whether or not they are all anagrams of each other
// Endpoint to return all anagram groups of size >= x
// Endpoint to delete a word and all of its anagrams

var Dictionary = function (path) {
  // Keep all of our words
  /*
    Any word not in this set will be assumed to be a proper noun.
    We assume that the english language is forever and will never
    change.
  */
  var dictionarySet = new Set();

  var wordSet = new Set();

  // Keep all of our anagrams
  /*
    'sorted_anagram_key': [all of the word combos found]
  */
  var anagrams = {};

  // Keep on going stats
  // Calculated for each word found
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
      weight: int,
      word_length_hash[key: word_length, value: number_of_words]: {
          1: total_words,
          .
          .
      }
  */
  var stats = {
    total_count: 0,
    min: null,
    median: null,
    average: null,
    weight: 0,
    word_length_hash: {}
  }

  // Given that our text file is small we can load the whole
  // file into heap space
  this.dictionary_defer = new Promise(function(resolve, reject) {
    var word = "";
    fs.createReadStream(path, {'encoding':'utf8'})
    .on('data', function(chunk) {
      var chunkArray = chunk.split('\n');
      while(chunkArray.length > 0) {
        // If word is incomplete continue
        wordResult = extractWord(word, chunkArray);
        if (wordResult[1]) {
          word = "";
          dictionarySet.add(wordResult[0].toLowerCase());
        }
      }
    }).on('error',function(error) {
      reject(error);
    }).on('end', function() {
      resolve(dictionary);
    })
  })

  var pushWord = function(word) {
    word = word.toLowerCase();

    // before adding any words lets see if it already exists
    // otherwise this will mess up our stats and anagrams
    if (wordSet.has(word)) return;

    wordSet.add(word);
    pushStats(word, stats);
    pushAnagram(word, anagrams);
  }

  var deleteWord = function(word) {
    word = word.toLowerCase();
    wordSorted = word.split('').sort().join('');
    if (!anagrams[wordSorted]) return;
    anagrams[wordSorted].delete(word);
    wordSet.delete(word);
    recomputeStats(word, stats);
  }

  // This gives access to our instance methods
  var dictionary = {
    pushWord: pushWord,
    getAnagram: function(word, properNoun) {
      word = word.toLowerCase();
      wordSorted = word.split('').sort().join('');

      if (!wordSet.has(word.toLowerCase())) return [];

      var _anagrams = Array.from(anagrams[wordSorted]);

      _anagrams = _anagrams.filter((_word) => {return _word !== word})

      if (!_anagrams) return [];

      if (properNoun === true) {
        return _anagrams.filter((_word) => {
          return !dictionarySet.has(_word);
        })
      }

      return _anagrams;
    },
    deleteWord: deleteWord,
    deleteWords: function(words) {
      if (words === null || words.length === 0) {
        wordSet = new Set();
        stats = {
          total_count: 0,
          min: null,
          median: null,
          average: null,
          weight: 0,
          word_length_hash: {}
        }
      } else {
        words.forEach((word) => {
          deleteWord(word);
        });
      }
    },
    getStats: function() {
      return stats;
    }
  }
}

exports.Dictionary = function(path) { return (new Dictionary(path)).dictionary_defer };
exports.__extractWord = extractWord;
exports.__pushStats = pushStats;
exports.__pushAnagram = pushAnagram;