defmodule ProgrammingElixir.Chapter6Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter6

  @moduletag :capture_log

  doctest Chapter6

  # Exercise modulesAndFunctions-1

  test "should return triple of n" do
    assert Chapter6.triple(6) == 18
  end

  # Exercise modulesAndFunctions-3

  test "should return quadruple of n" do
    assert Chapter6.quadruple(4) == 16
  end

  # Exercise modulesAndFunctions-4

  test "should return 0 for sum(0)" do
    assert Chapter6.sum(0) == 0
  end

  test "should return 1 for sum(1)" do
    assert Chapter6.sum(0) == 0
  end

  test "should return 3 for sum(2)" do
    assert Chapter6.sum(2) == 3
  end

  test "should return 55 for sum(10)" do
    assert Chapter6.sum(10) == 55
  end

  # Exercise modulesAndFunctions-5

  test "should return 1 for gcd(5,2)" do
    assert Chapter6.gcd(5, 2) == 1
  end

  test "should return 3 for gcd(9,6)" do
    assert Chapter6.gcd(9, 6) == 3
  end

  test "should return 2 for gcd(2,0)" do
    assert Chapter6.gcd(2, 0) == 2
  end

  # Exercise modulesAndFunctions-6
  test "should return 273 for guess(273,1..1000)" do
    assert Chapter6.guess(273, 1..1000) == 273
  end

  test "should return 273 for guess(300,250..1000)" do
    assert Chapter6.guess(300, 250..1000) == 300
  end
end
