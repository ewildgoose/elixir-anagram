defmodule AnagramFinderTest do
  use ExUnit.Case
  doctest Anagram.Finder

  @dictionary "./test/test_dict.txt"
  @dict Anagram.Finder.load_dictionary(@dictionary)

  test "make words from hello" do
    assert ["hell", "hello"] == Anagram.Finder.words_from("hello", @dictionary) |> Enum.sort
  end

  test "find anagram" do
    assert ["hello"] == Anagram.Finder.anagrams("olleh", false, @dict)
  end

  test "find anagram without repeats" do
    assert [] == Anagram.Finder.anagrams("hello", true, @dict)
  end

end
