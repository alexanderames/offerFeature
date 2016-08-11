var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/anagrams/:word', function(req, res, next) {
  var word = req.params.word;
  res.status(200);
  var properNoun = req.query.properNoun === "true";
  var anagrams = req.dictionary.getAnagram(word, properNoun);
  if (req.query.limit && parseInt(req.query.limit) > 0) {
    anagrams = anagrams.splice(0,parseInt(req.query.limit));
  }
  res.json({anagrams: anagrams});
});

router.post('/words', function(req, res, next) {
  req.body.words.forEach((word) => {
    req.dictionary.pushWord(word)
  })
  res.status(201);
  res.json();
});

router.delete('/words/:word', function(req, res, next) {
  req.dictionary.deleteWord(req.params.word);
  res.json();
});

router.delete('/words', function(req, res, next) {
  if (req.body.words) {
    req.dictionary.deleteWords(req.body.words);  
  } else {
    req.dictionary.deleteWords(null);
  }
  res.status(204);
  res.json();
});

router.get('/stats', function(req, res, next) {
  res.json({stats: req.dictionary.getStats()});
});

/*
POST /words.json: Takes a JSON array of English-language words and adds them to the corpus (data store).
GET /anagrams/:word.json:
Returns a JSON array of English-language words that are anagrams of the word passed in the URL.
This endpoint should support an optional query param that indicates the maximum number of results to return.
DELETE /words/:word.json: Deletes a single word from the data store.
DELETE /words.json: Deletes all contents of the data store.
*/

module.exports = router;