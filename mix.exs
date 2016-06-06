defmodule Anagram.Mixfile do
  use Mix.Project

  def project do
    [app: :anagram,
     version: "1.0.0",
     elixir: "~> 1.2",
     description: description,
     package: package,
     source_url: "https://github.com/ewildgoose/elixir-anagram",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
  [{:earmark, "~> 0.1", only: :dev},
   {:ex_doc, "~> 0.11", only: :dev}]
  end

  defp description do
    """
    Find anagrams of words and "words that can be made with a set of letters" (sort of a sub anagram)
    """
  end

  defp package do
    [
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Ed Wildgoose"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/ewildgoose/elixir-anagram"}
   ]
  end

end
