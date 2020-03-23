defmodule ProgrammingElixir.Chapter18Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter18

  @moduletag :capture_log

  doctest Chapter18

  @stack ProgrammingElixir.Chapter18.Stack
  @withStash ProgrammingElixir.Chapter18.StackWithStash

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

  # we add a special keyword to the initial stack, when pop operation reach to that value it throws exception and after restart we have empty stack
  test "supervisor should restart process after failure but cannot remember the last state" do
    ProgrammingElixir.Chapter18.StackApp.start([])

    GenServer.cast(@stack, {:push, 3})
    GenServer.cast(@stack, {:push, "kill"})
    GenServer.cast(@stack, {:push, 1})

    assert GenServer.call(@stack, :pop) == 1

    # we reach to 'kill' keyword
    assert catch_exit(GenServer.call(@stack, :pop))

    # just give sometime for supervisor to start the Stack process - it should be emtpy after restart
    :timer.sleep(2000)

    # pop from empty stack
    assert catch_exit(GenServer.call(@stack, :pop))
    :timer.sleep(2000)

    GenServer.cast(@stack, {:push, 1})
    GenServer.cast(@stack, {:push, 2})
    assert GenServer.call(@stack, :pop) == 2
    assert GenServer.call(@stack, :pop) == 1
  end

  test "supervisor should restart process after failure and remember last state before crash" do
    ProgrammingElixir.Chapter18.StackAppWithStash.start([])

    GenServer.cast(@withStash, {:push, 4})
    GenServer.cast(@withStash, {:push, 3})
    GenServer.cast(@withStash, {:push, "kill"})
    GenServer.cast(@withStash, {:push, 1})

    assert GenServer.call(@withStash, :pop) == 1

    # we reach to 'kill' keyword and here process is going crash
    assert catch_exit(GenServer.call(@withStash, :pop))

    # just give sometime for supervisor to start the Stack process - it should contain whatever left after 'kill'
    :timer.sleep(2000)
    # pop from stack
    assert GenServer.call(@withStash, :pop) == 3
    assert GenServer.call(@withStash, :pop) == 4
  end
end
