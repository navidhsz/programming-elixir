defmodule ProgrammingElixir.Chapter2Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter2

  @moduletag :capture_log

  doctest Chapter2

  ##### Exercise: patten-matching-1

  test " a = [1,2,3] " do
    assert match?(a, [1,2,3])
  end

  test " a = 4 , 4 =a " do
    a = 4
    assert match?(a, 4)
    assert match?(4, a)
  end

  test " [a,b] = [1,2,3] " do
     refute match?([a,b], [1,2,3])
  end

  test " a = [[1,2,3]] " do
    assert match?(a, [[1,2,3]])
  end

  test " [a] = [[1,2,3]] " do
    assert match?([a], [[1,2,3]])
  end

  test " [[a]] = [[1,2,3]] " do
    refute match?([[a]], [[1,2,3]])
  end

  ##### Exercise: patten-matching-2

  test " [a,b,a] = [1,2,3] " do
    refute match?([a,b,a], [1,2,3])
  end

  test " [a,b,a] = [1,1,2] " do
    refute match?([a,b,a], [1,1,2])
  end

  test " [a,b,a] = [1,2,1] " do
    assert match?([a,b,a], [1,2,1])
  end

  ##### Exercise: patten-matching-3

  test " a = 1 , ^a = 2 , ^a = 1" do
    a = 2
    refute match?([a,b,a], [1,2,3])
    refute match?([a,b,a], [1,1,2])
    a = 1
    assert match?(a, 1)
    refute match?(^a, 2)
    assert match?(^a, 1)
    assert match?(^a, 2 - a)
  end

end
