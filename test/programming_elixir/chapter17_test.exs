defmodule ProgrammingElixir.Chapter17Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter17

  @moduletag :capture_log

  doctest Chapter17

  # Exercise: OTP-Server-1 , OTP-Server-2 , OTP-Server-3

  test "pop operation of stack" do
    {:ok, _pid} =
      GenServer.start_link(ProgrammingElixir.Chapter17.Stack, [5, "cat", 9], name: :stack)

    assert GenServer.call(:stack, :pop) == 5
    assert GenServer.call(:stack, :pop) == "cat"
    assert GenServer.call(:stack, :pop) == 9
    assert catch_exit(GenServer.call(:stack, :pop))
  end

  test "push operation of stack" do
    {:ok, _pid} = GenServer.start_link(ProgrammingElixir.Chapter17.Stack, [], name: :stack)
    GenServer.cast(:stack, {:push, 9})
    GenServer.cast(:stack, {:push, "cat"})
    GenServer.cast(:stack, {:push, 5})

    assert GenServer.call(:stack, :pop) == 5
    assert GenServer.call(:stack, :pop) == "cat"
    assert GenServer.call(:stack, :pop) == 9
  end

  # Exercise: OTP-Server-4

  test "push/pop operation using API" do
    stack_name = :my_stack
    Chapter17.Stack.create([], stack_name)
    Chapter17.Stack.push(9, stack_name)
    Chapter17.Stack.push("cat", stack_name)
    Chapter17.Stack.push(5, stack_name)

    assert Chapter17.Stack.pop(stack_name) == 5
    assert Chapter17.Stack.pop(stack_name) == "cat"
    assert Chapter17.Stack.pop(stack_name) == 9
  end
end
