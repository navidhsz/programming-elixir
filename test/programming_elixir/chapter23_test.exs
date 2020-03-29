defmodule ProgrammingElixir.Chapter23Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter23

  @moduletag :capture_log

  doctest Chapter23

  test "Tracer module - no assertion" do
    Chapter23.Test.add_list([1, 2, 3])
  end

  # Exercise: LinkingModules-BehavioursAndUse-2

  test "io ansi - no assertion" do
    Chapter23.Exercise2.print()
  end

  # Exercise: LinkingModules-BehavioursAndUse-3

  test "Tracer module with func_with_guard - no assertion" do
    assert Chapter23.Test.func_with_guard(10, 2, 3) == 15
  end
end
