defmodule ProgrammingElixir.Chapter17Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter17

  @moduletag :capture_log

  doctest Chapter17

  test "pop operation of stack" do
    {:ok, pid} = GenServer.start_link(ProgrammingElixir.Chapter17.Stack, [5, "cat", 9])
    assert GenServer.call(pid, :pop) == 5
    assert GenServer.call(pid, :pop) == "cat"
    assert GenServer.call(pid, :pop) == 9
    assert catch_exit(GenServer.call(pid, :pop))
  end

  test "push operation of stack" do
    {:ok, pid} = GenServer.start_link(ProgrammingElixir.Chapter17.Stack, [])
    GenServer.cast(pid, {:push, 9})
    GenServer.cast(pid, {:push, "cat"})
    GenServer.cast(pid, {:push, 5})

    assert GenServer.call(pid, :pop) == 5
    assert GenServer.call(pid, :pop) == "cat"
    assert GenServer.call(pid, :pop) == 9
  end
end
