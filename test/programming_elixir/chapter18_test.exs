defmodule ProgrammingElixir.Chapter18Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter18

  @moduletag :capture_log

  doctest Chapter18

  @stack ProgrammingElixir.Chapter18.Stack

  test "supervisor should restart process after failure" do
    ProgrammingElixir.Chapter18.StackApp.start([1, 2, 3])

    assert GenServer.call(@stack, :pop) == 1
    assert GenServer.call(@stack, :pop) == 2
    assert GenServer.call(@stack, :pop) == 3

    # this raise exception in the Stack process but, supervisor restart it
    assert catch_exit(GenServer.call(@stack, :pop))
    # just give sometime for supervisor to start the Stack process
    :timer.sleep(2000)

    GenServer.cast(@stack, {:push, 1})
    GenServer.cast(@stack, {:push, 2})
    assert GenServer.call(@stack, :pop) == 2
    assert GenServer.call(@stack, :pop) == 1
  end
end
