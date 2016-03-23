Ibotta Dev Project
=========


# The Project

---

The project is to build an API that allows fast searches for [anagrams](https://en.wikipedia.org/wiki/Anagram). `dictionary.txt` is a text file containing every word in the English dictionary. Ingesting the file doesn’t need to be fast, and you can store as much data in memory as you like.

The API you design should respond on the following endpoints as specified.

- `POST /words/new.json`: Takes a JSON array of English-language words and adds them to the corpus (data store).
- `GET /words/stats.json`: Returns count of words and average word length
- `GET /anagrams/:word.json`:
  - Returns a JSON array of English-language words that are anagrams of the word passed in the URL.
  - This endpoint should support an optional query param that indicates the maximum number of results to return.


Clients will interact with the API over HTTP, and all data sent and received is expected to be in JSON format

Example (assuming the API is being served on localhost port 3000):

```{bash}
# Adding words to the corpus
$ curl -i -X POST -d '["read", "dear", "dare"]' http://localhost:3000/words/new.json
HTTP/1.1 200 OK
...

# Corpus statistics
$ curl -i http://localhost:3000/words/stats.json
HTTP/1.1 200 OK
...
{
  count: 3,
  average_length: 4.0
}

# Fetching anagrams
$ curl -i http://localhost:3000/anagrams/read.json
HTTP/1.1 200 OK
...
{
  anagrams: [
    "dear",
    "dare"
  ]
}

# Specifying maximum number of anagrams
$ curl -i http://localhost:3000/anagrams/read.json?max=1
HTTP/1.1 200 OK
...
{
  anagrams: [
    "dear"
  ]
}
```

Note that a word is not considered to be its own anagram.

## Tests

We have provided a suite of tests to help as you develop the API. To run the tests you must have Ruby installed ([docs](https://www.ruby-lang.org/en/documentation/installation/)):

```
ruby anagram_test.rb
```

If you are running your server somewhere other than localhost port 3000, you can configure the test runner with configuration options described by

```
ruby anagram_test.rb --help
```

You are welcome to add additional tests if that helps with your development process.

## Documentation

Optionally, you can provide documentation that is useful to consumers and/or maintainers of the API.

Suggestions for documentation topics include:

- Features you think would be useful to add to the API
- Implementation details (which data store you used, etc.)
- Limits on the length of words that can be stored or limits on the number of results that will be returned
- Any edge cases you find while working on the project
- Design overview and trade-offs you considered


# Deliverable
---

Please provide the code for the assignment either in a private repository (GitHub or Bitbucket) or as a zip file. If you have a deliverable that is deployed on the web please provide a link, otherwise give us instructions for running it locally.
