defmodule ProgrammingElixir.Chapter7Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter7

  @moduletag :capture_log

  doctest Chapter7

  # Exercise listAndRecursion-1

  test "should return 14 for mapsum([,2,3],&(&1*&1)" do
    assert Chapter7.mapsum([1,2,3],&(&1*&1)) == 14
  end

  # Exercise listAndRecursion-2

  test "should return 60 for max([1,2,3,4,20,40,10,5,60])" do
    assert Chapter7.max([1,2,3,40,-20,40,10,5,60]) == 60
  end

  # Exercise listAndRecursion-3

  test "should return 'elixir' for caesar('ryvkve',13)" do
    assert Chapter7.caesar('ryvkve',13) == 'elixir'
  end

  # Exercise listAndRecursion-4

  test "should return '[5,6,7,8,10]' for span(5,10)" do
    assert Chapter7.span(5,10) == [5,6,7,8,9,10]
  end

end
