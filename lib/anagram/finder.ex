defmodule Anagram.Finder do

  @dictionary "/usr/share/dict/web2"

  @doc """
  Load the given dictionary for later use by our anagram finder

  Format is a map, where
  - the keys are a normalised form of the word (lower case + sorted)
  - the values are a list of anagrams of these letters

  Finding anagrams is simply a case of normalising a candidate word and then
  looking up all the anagrams from our dictionary
  """
  def load_dictionary(path \\ @dictionary) do
    File.stream!(path, [], :line)
    |> Enum.reduce(Map.new, &add_word/2)
  end

  @doc """
  Add a word to our anagrams dictionary

      iex> Anagram.Finder.add_word("sober", Map.new)
      %{"beors" => ["sober"]}

      iex> ["sober", "robes"] |> Enum.reduce(Map.new, &Anagram.Finder.add_word/2)
      %{"beors" => ["robes", "sober"]}
  """
  def add_word(word, dict) do
    word = String.strip(word)
    canon = canonicalise(word)

    Map.update(dict, canon, [word], fn(anagrams) -> [word|anagrams] end)
  end

  @doc """
  Find all anagrams of the given word (from our dictionary). Returns a list

  For repeated searches its highly recommended to preload the dictionary
  using load_dictionary/1 and pass it to this function

  The default dictionary will be web2, ie assumes a unixy OS. Load your own
  dictionary if this isn't present/wanted
  """
  def anagrams(word, remove_self \\ false, dict \\ load_dictionary())

  def anagrams(word, false, dict) when is_map(dict) do
    Map.get(dict, canonicalise(word), [])
  end

  def anagrams(word, true, dict) when is_map(dict) do
      anagrams(word, false, dict)
      |> Enum.filter(fn(anagram) -> word != anagram end)
  end

  @doc """
  Find all words in our given dictionary, which can be made from a subset of
  the given letters (case insensitive)

  letters can be passed either as a bitstring or as a list of individual (bitstring) letters
  Dictionary defaults to: @dictionary
  """
  def words_from(letters, dictionary \\ @dictionary)

  def words_from(letters, dictionary) when is_bitstring(letters) do
    letters = String.graphemes(letters)
    words_from(letters, dictionary)
  end

  def words_from(letters, dictionary) when is_list(letters) do
    File.stream!(dictionary, [], :line)
    |> Stream.map(&String.strip/1)
    |> Enum.filter( fn(word) -> is_made_from(word, letters) end )
  end


  @doc """
  Test if our candidate word can be made using only the given letters (case insensitive)
  """
  def is_made_from(word, letters) when is_list(letters) do
    word_letters = word
                  |> String.downcase
                  |> String.graphemes

    # return TRUE if the word is from a subset of our letters
    word_letters -- letters
    |> Enum.empty?
  end

  @doc ~S"""
  Canonicalise the word by sorting it's characters

      iex> Anagram.Finder.canonicalise("hello\r\n")
      "ehllo"
  """
  def canonicalise(word) do
    word
    |> String.strip
    |> String.downcase
    |> String.graphemes
    |> Enum.sort
    |> Enum.join
    |> String.strip
  end
end
