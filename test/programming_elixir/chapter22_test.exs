defmodule ProgrammingElixir.Chapter22Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter22

  @moduletag :capture_log

  doctest Chapter22

  require Chapter22.My
  require ProgrammingElixir.Chapter22.TestExercise2

  # Exercise: MacrosAndCodeEvaluation-1

  test "unless macro do-clause" do
    lst = [1, 2, 3]

    Chapter22.My.unless 1 in lst do
      assert false
    else
      assert true
    end
  end

  test "unless macro else-clause" do
    lst = [1, 2, 3]

    Chapter22.My.unless 0 in lst do
      assert true
    else
      assert false
    end
  end

  # Exercise: MacrosAndCodeEvaluation-2

  test "time_n macro for times_3(4)" do
    assert Chapter22.TestExercise2.times_3(4) == 12
  end

  test "time_n macro for times_4(5)" do
    assert Chapter22.TestExercise2.times_4(5) == 20
  end
end
