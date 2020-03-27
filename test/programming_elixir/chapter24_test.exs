defmodule ProgrammingElixir.Chapter24Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter24

  @moduletag :capture_log

  doctest Chapter24

  require Chapter24.My

  # Exercise: MacrosAndCodeEvaluation-1

  test "unless macro do-clause" do
    lst = [1, 2, 3]

    Chapter24.My.unless 1 in lst do
      assert false
    else
      assert true
    end
  end

  test "unless macro else-clause" do
    lst = [1, 2, 3]

    Chapter24.My.unless 0 in lst do
      assert true
    else
      assert false
    end
  end
end
