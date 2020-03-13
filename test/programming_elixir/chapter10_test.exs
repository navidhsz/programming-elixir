defmodule ProgrammingElixir.Chapter10Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter10

  @moduletag :capture_log

  doctest Chapter10

  # Exercise listAndRecursion-5

  test "should return [5,4,3,2,1] for reverse([1,2,3,4,5])" do
    assert Chapter10.reverse([1,2,3,4,5]) == [5,4,3,2,1]
  end

  ### all?
  test "should return 'true' for all?([2,4,6],fn n -> rem(n,2) == 0 end)" do
    assert Chapter10.all?([2,4,6],fn n -> rem(n,2) == 0 end) == true
  end
  test "should return 'false' for all?([2,4,6],fn n -> n < 6 end)" do
    assert Chapter10.all?([2,4,6],fn n -> n < 6 end) == false
  end

  ### each
  test "should return :ok" do
    assert Chapter10.each(["hello","world"],fn n -> IO.puts(n) end) == :ok
  end

  ### filter
  test "should return [1,2] for filter([1,2,3,4,5],fn n -> n < 3 end)" do
    assert Chapter10.filter([1,2,3,4,5],fn n -> n<3 end) == [1,2]
  end

  ### split
  test "should return {[],[1,2,3]} for split([1,2,3],0)" do
    assert Chapter10.split([1,2,3],0) == {[],[1,2,3]}
  end
  test "should return {[1,2],[3,4,5]} for split([1,2,3,4,5],2)" do
    assert Chapter10.split([1,2,3,4,5],2) == {[1,2],[3,4,5]}
  end

  ### take
  test "should return [1, 2] for take([1, 2, 3], 2)" do
    assert Chapter10.take([1, 2, 3], 2) == [1, 2]
  end
  test "should return [1, 2, 3] for take([1, 2, 3], 10)" do
    assert Chapter10.take([1, 2, 3], 10) == [1, 2, 3]
  end
  test "should return [] for take([1, 2, 3], 0)" do
    assert Chapter10.take([1, 2, 3], 0) == []
  end
  test "should return [3] for take([1, 2, 3], -1)" do
    assert Chapter10.take([1, 2, 3], -1) == [3]
  end
  test "should return [5, 4, 3] for take([1, 2, 3, 4, 5], -1)" do
    assert Chapter10.take([1, 2, 3, 4, 5], -3) == [5,4,3]
  end

end
