defmodule ProgrammingElixir.Chapter5Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter5

  @moduletag :capture_log

  doctest Chapter5

  # Exercise function-1

  test " sum.(1,2,3) # => 6 " do
    assert Chapter5.sum(1, 2, 3) == 6
  end

  test " list_concat([:a,:b],[:c,:d]) # => [:a,:b,:c,:d] " do
    assert Chapter5.list_concat([:a, :b], [:c, :d]) == [:a, :b, :c, :d]
  end

  test " pair_tuple_to_list({1234,5678}) # => [1234,5678] " do
    assert Chapter5.pair_tuple_to_list({1234, 5678}) == [1234, 5678]
  end

  # Exercise function-2

  test "should return 'FizzBuzz' when first two parameters are zero" do
    assert Chapter5.fizz_buzz(0, 0, "third") == "FizzBuzz"
  end

  test "should return 'Fizz' when first parameter is zero" do
    assert Chapter5.fizz_buzz(0, "second", "third") == "Fizz"
  end

  test "should return 'Buzz' when second parameter is zero" do
    assert Chapter5.fizz_buzz("first", 0, "third") == "Buzz"
  end

  test "should return third parameter if none of above is valid" do
    assert Chapter5.fizz_buzz("first", "second", "third") == "third"
  end

  # Exercise function-3

  test "should return 'Buzz' for n=10" do
    assert Chapter5.exercise3(10) == "Buzz"
  end

  test "should return '11' for n=11" do
    assert Chapter5.exercise3(11) == 11
  end

  test "should return 'Fizz' for n=12" do
    assert Chapter5.exercise3(12) == "Fizz"
  end

  test "should return '13' for n=13" do
    assert Chapter5.exercise3(13) == 13
  end

  test "should return '14' for n=14" do
    assert Chapter5.exercise3(14) == 14
  end

  test "should return 'FizzBuzz' for n=15" do
    assert Chapter5.exercise3(15) == "FizzBuzz"
  end

  test "should return '16' for n=16" do
    assert Chapter5.exercise3(16) == 16
  end

  # Exercise function-4

  test "should return 'hello world'" do
    innerFunc = Chapter5.prefix("hello")
    assert innerFunc.("world") == "hello world"
  end

  # Exercise function-5

  test "Enum.map shortcut function" do
    lst = [1, 2, 3, 4]
    map = Enum.map(lst, fn x -> x + 2 end)
    assert map == Chapter5.map(lst)
  end

  test "Enum.each with shortcut" do
    lst = [1, 2, 3, 4]
    each = Enum.each(lst, fn x -> IO.inspect(x) end)
    assert each == Chapter5.each(lst)
  end
end
