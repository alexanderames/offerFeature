Ibotta Dev Project
=========


# The Project

---

The project is to build an API that allows fast searches for [anagrams](https://en.wikipedia.org/wiki/Anagram). `dictionary.txt` is a text file containing every word in the English dictionary. Ingesting the file doesn’t need to be fast, and you can store as much data in memory as you like.

The API you design should respond on the following endpoints as specified.

- `POST /words/new.json`: Takes a JSON array of English-language words and adds them to the corpus (data store).
- `GET /anagrams.json`: Returns a JSON array of English-language words that are anagrams of the word in the query string.

Clients will interact with the API over HTTP, and all data sent and received is expected to be in JSON format

Example (assuming the API is being served on localhost port 3000):

```
$ curl -i -X POST -d '["read", "dear", "dare"]' http://localhost:3000/words/new.json
HTTP/1.1 200 OK
...

$ curl -i http://localhost:3000/anagrams.json?word=read
HTTP/1.1 200 OK
...
{
  anagrams: [
    "dear",
    "dare"
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

Extra credit will be given for submissions that provide documentation that is useful to consumers and/or maintainers of the API.

Suggestions for documentation topics include:

- Features you think would be useful to add to the API
- Implementation details (which data store you used, etc.)
- Limits on the length of words that can be stored or limits on the number of results that will be returned
- Any edge cases you find while working on the project.


# Deliverable
---

Please provide the code for the assignment either in a private repository (GitHub or Bitbucket) or as a zip file. If you have a deliverable that is deployed on the web please provide a link, otherwise give us instructions for running it locally.
