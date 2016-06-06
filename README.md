# Anagram

Useful functions to find anagrams of words and
"words that can be made with a set of letters" (sort of a sub anagram)

Our algorithm for anagrams is simply to canonicalise each word in the dictionary
by forcing case, removing whitespace and sorting the characters. This will
mean that all words with the same constituent letters in some permuted order,
will have the same canonicalised form.  Now we simply stuff our words into a
Map, where the key is our canonicalised form

Finding anagrams is simply a case of canonicalising the word we are after
and searching for an entry in the Map with that key

For speed, load the dictionary once and hang onto it and pass to the anagram function

# Examples

    iex> Anagram.anagrams("robe")
    ["robe", "bore", "Boer"]

    # Remove the word passed in from results
    iex> Anagram.anagrams("robe", true)
    ["bore", "Boer"]

    # Find words we can make from the letters "piz"
    # Note the apparent duplicates are in the web2 dictionary on OSX...
    iex> Anagram.words_from("piz")
    ["I", "i", "P", "p", "pi", "Z", "z", "zip"]

## Installation

The package can be installed as:

  1. Add anagram to your list of dependencies in `mix.exs`:

        def deps do
          [{:anagram, "~> 1.0.0"}]
        end


