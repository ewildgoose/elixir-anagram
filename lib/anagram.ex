defmodule Anagram do

  @dictionary "/usr/share/dict/web2"

  @moduledoc """
  Useful functions to find anagrams of words and words that can be made with a
  set of letters (sort of a sub anagram)

  Our algorithm for anagrams is simply to canonicalise each word in the dictionary
  by forcing case, removing whitespace and sorting the characters. This will
  mean that all words with the same constituent letters in some permuted order,
  will have the same canonicalised form.  Now we simply stuff our words into a
  Map, where the key is our canonicalised form

  Finding anagrams is simply a case of canonicalising the word we are after
  and searching for an entry in the Map with that key

  For speed, load the dictionary once and hang onto it and pass to the anagram function
  """

  @doc """
  Load the given dictionary for later use by our anagram finder

  Format is a map, where
  - the keys are a normalised form of the word (lower case + sorted)
  - the values are a list of anagrams of these letters

  Finding anagrams is simply a case of normalising a candidate word and then
  looking up all the anagrams from our dictionary
  """
  def load_dictionary(path \\ @dictionary) do
    Anagram.Finder.load_dictionary(path)
  end

  @doc """
  Find all anagrams of the given word (from our dictionary). Returns a list

  For repeated searches its highly recommended to preload the dictionary
  using load_dictionary/1 and pass it to this function

  The default dictionary will be web2, ie assumes a unixy OS. Load your own
  dictionary if this isn't present/wanted
  """
  def anagrams(word, remove_self \\ false) do
    Anagram.Finder.anagrams(word, remove_self)
  end

  def anagrams(word, remove_self, dict) do
    Anagram.Finder.anagrams(word, remove_self, dict)
  end

  @doc """
  Find all words in our given dictionary file, which can be made from a subset of
  the given letters (case insensitive)

  letters can be passed either as a bitstring or as a list of individual (bitstring) letters

  Default dictionary is web2, ie assumes a unixy OS. Specify your own dictionary
  if this isn't present/wanted
  """
  def words_from(word, dictionary \\ @dictionary) do
    Anagram.Finder.words_from(word, dictionary)
  end

end
