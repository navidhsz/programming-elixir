defmodule ProgrammingElixir.Chapter11 do
  @moduledoc false

  # Exercise StringsAndBinaries-1
  def isASCIIPrintable([]), do: true
  def isASCIIPrintable([head | tail]) do
    ?\s <= head and head <= ?~ and isASCIIPrintable(tail)
  end


  # Exercise StringsAndBinaries-2
  def anagram?(word1,word2) do
    String.bag_distance(String.downcase(word1),String.downcase(word2)) === 1.0
  end


end
