defmodule ProgrammingElixir.Chapter12Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter12

  @moduletag :capture_log

  doctest Chapter12

  # Exercise: ControlFlow-1 ,2

  test "fizzbuzz(15) should return 'FizzBuzz'" do
    assert Chapter12.fizzbuzz(15) == "FizzBuzz"
  end

  test "fizzbuzz(3) should return 'Fizz'" do
    assert Chapter12.fizzbuzz(3) == "Fizz"
  end

  test "fizzbuzz(25) should return 'Fizz'" do
    assert Chapter12.fizzbuzz(25) == "Buzz"
  end

  test "fizzbuzz(14) should return '14'" do
    assert Chapter12.fizzbuzz(14) == 14
  end

  # Exercise: ControlFlow-3

  test "should return 'myData' for ok!({:ok,'myData'})" do
    assert Chapter12.ok!({:ok, "myData"}) == "myData"
  end

  test "should throw exception for ok!('test')" do
    assert_raise RuntimeError, fn -> Chapter12.ok!("test") end
  end

  test "should throw exception for ok!({:error,'test'})" do
    assert_raise RuntimeError, fn -> Chapter12.ok!({:error, "test"}) end
  end
end
