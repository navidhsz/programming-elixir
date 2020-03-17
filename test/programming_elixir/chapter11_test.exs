defmodule ProgrammingElixir.Chapter11Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter11

  @moduletag :capture_log

  doctest Chapter11

  # Exercise StringsAndBinaries-1
  test "should return 'true' for isASCIIPrintable('~Z/ \ test')" do
    assert Chapter11.isASCIIPrintable('~Z/ \ test') == true
  end

  test "should return 'false' for isASCIIPrintable('@ % ` Ÿ')" do
    assert Chapter11.isASCIIPrintable('@ % ` Ÿ') == false
  end

  # Exercise StringsAndBinaries-2
  test "should return 'true' for anagram?('cat'','act'')" do
    assert Chapter11.anagram?("cat", "act") == true
  end

  test "should return 'true' for anagram?('Listen','Silent')" do
    assert Chapter11.anagram?("Listen", "Silent") == true
  end

  test "should return 'true' for anagram?('Listens','Silent')" do
    assert Chapter11.anagram?("Listens", "Silent") == false
  end
end
