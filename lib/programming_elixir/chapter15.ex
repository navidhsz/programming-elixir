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

  # Exercise: Working with multiple processes-8

  defmodule FibSolver do
    def fib(scheduler) do
      send(scheduler, {:ready, self()})

      receive do
        {:fib, n, client} ->
          send(client, {:answer, n, fib_calc(n), self()})
          fib(scheduler)

        {:shutdown} ->
          exit(:normal)
      end
    end

    defp fib_calc(0), do: 0
    defp fib_calc(1), do: 1
    defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
  end

  defmodule Scheduler do
    def run(num_processes, module, func, to_calculate) do
      1..num_processes
      |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
      |> schedule_processes(to_calculate, [])
    end

    defp schedule_processes(processes, queue, results) do
      receive do
        {:ready, pid} when length(queue) > 0 ->
          [next | tail] = queue
          send(pid, {:fib, next, self()})
          schedule_processes(processes, tail, results)

        {:ready, pid} ->
          send(pid, {:shutdown})

          if length(processes) > 1 do
            schedule_processes(List.delete(processes, pid), queue, results)
          else
            Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
          end

        {:answer, number, result, _pid} ->
          schedule_processes(processes, queue, [{number, result} | results])
      end
    end
  end

  # Exercise: Working with multiple processes-9

  defmodule ProcessorExercise9 do
    def processor(scheduler) do
      send(scheduler, {:ready, self()})

      receive do
        {:calc, {n, token}, client} ->
          send(client, {:answer, n, job(n, token), self()})
          processor(scheduler)

        {:shutdown} ->
          exit(:normal)
      end
    end

    defp job(n, word) do
      File.read!(n)
      |> String.split()
      |> Enum.filter(fn t -> String.contains?(t, word) end)
      |> Enum.count()
    end
  end

  defmodule SchedulerExercise9 do
    def run(num_processes, module, func, to_calculate, token) do
      1..num_processes
      |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
      |> schedule_processes(to_calculate, [], token)
    end

    defp schedule_processes(processes, queue, results, token) do
      receive do
        {:ready, pid} when length(queue) > 0 ->
          [next | tail] = queue
          send(pid, {:calc, {next, token}, self()})
          schedule_processes(processes, tail, results, token)

        {:ready, pid} ->
          send(pid, {:shutdown})

          if length(processes) > 1 do
            schedule_processes(List.delete(processes, pid), queue, results, token)
          else
            Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
          end

        {:answer, number, result, _pid} ->
          schedule_processes(processes, queue, [{number, result} | results], token)
      end
    end
  end
end
