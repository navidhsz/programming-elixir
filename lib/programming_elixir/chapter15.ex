defmodule ProgrammingElixir.Chapter15 do
  @moduledoc false

  # Exercise: Working with multiple processes-1

  def counter(next_pid) do
    receive do
      n -> send(next_pid, n + 1)
    end
  end

  def create_processes(n) do
    code_to_run = fn _, send_to -> spawn(ProgrammingElixir.Chapter15, :counter, [send_to]) end
    last = Enum.reduce(1..n, self(), code_to_run)
    send(last, 0)

    receive do
      final_answer when is_integer(final_answer) -> "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    :timer.tc(ProgrammingElixir.Chapter15, :create_processes, [n]) |> IO.inspect()
  end

  # Exercise: Working with multiple processes-2
  # spawning process is not deterministic, but messages published to the mailbox of a process will be processed in order (deterministic)

  def process(name, token, canAccept) do
    receive do
      {sender, message} when token == message ->
        IO.inspect("received on message=#{message} on process=#{name}")
        send(sender, message)
    end
  end

  def runExercise2() do
    token1 = :fred
    token2 = :betty
    pid1 = spawn(ProgrammingElixir.Chapter15, :process, [:process1, token1, true])
    send(pid1, {self, token1})
    # make sure token2 is published after token1. Not an elegant way to handle ordering!
    :timer.sleep(1000)
    pid2 = spawn(ProgrammingElixir.Chapter15, :process, [:process2, token2, false])
    send(pid2, {self, token2})
  end

  # Exercise: Working with multiple processes-3

  def processExercise3(parent) do
    send(parent, {self(), :testMsg})

    # with this line commented test will fails because parent process does not have enough time to receive the message
    :timer.sleep(100)
    exit(:exit)
  end

  # Exercise: Working with multiple processes-4

  def processExercise4(parent) do
    send(parent, {self(), :testMsg})

    # with this line commented test will fails because parent process does not have enough time to receive the message
    :timer.sleep(100)
    raise "test exception"
  end

  # Exercise: Working with multiple processes-5_1

  def processExercise5_1(parent) do
    send(parent, {self(), :testMsg})
    exit(:exit)
  end

  # Exercise: Working with multiple processes-5_2

  def processExercise5_2(parent) do
    send(parent, {self(), :testMsg})
    raise "test exception"
  end

  # Exercise: Working with multiple processes-6
  # me = self() is PID for parent process however self() inside "spawn_link" means PID of the current child process created by spawn_link

  # Exercise: Working with multiple processes-7
  # by increasing list size (1..100) we can reproduce issue with not using pinned "pid" (^pid)
  def pmap(collection, fun) do
    me = self()

    collection
    |> Enum.map(fn elem ->
      spawn_link(fn ->
        send(me, {self(), fun.(elem)})
      end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} ->
          result
      end
    end)
  end
end
