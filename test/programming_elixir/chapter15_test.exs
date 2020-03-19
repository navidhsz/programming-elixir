defmodule ProgrammingElixir.Chapter15Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter15

  @moduletag :capture_log

  doctest Chapter15

  setup_all do
    [number_of_files: 10, token: "cat"]
  end

  # Exercise: Working with multiple processes-1

  test "nothing to test - Exec1" do
    Chapter15.run(1000)
  end

  # Exercise: Working with multiple processes-2

  test "should receive tokens in order" do
    Chapter15.runExercise2()

    receive do
      message -> assert message == :fred
    end

    receive do
      message -> assert message == :betty
    end
  end

  # Exercise: Working with multiple processes-3

  test "should have valid pid and message - processes-3" do
    pid = spawn_link(ProgrammingElixir.Chapter15, :processExercise3, [self()])

    # :timer.sleep(500)  # with this line uncommented test will fails because parent process gets shutdown
    receive do
      {sender, message} ->
        IO.inspect("pid=#{inspect(pid)} , sender=#{inspect(sender)} , message=#{message}")
        assert pid == sender
        assert message == :testMsg
    end
  end

  # Exercise: Working with multiple processes-4

  test "should have valid pid and message - processes-4" do
    pid = spawn_link(ProgrammingElixir.Chapter15, :processExercise4, [self()])

    # :timer.sleep(500)  # with this line uncommented test will fails because parent process gets shutdown
    receive do
      {sender, message} ->
        IO.inspect("pid=#{inspect(pid)} , sender=#{inspect(sender)} , message=#{message}")
        assert pid == sender
        assert message == :testMsg
    end
  end

  # Exercise: Working with multiple processes-5_1

  test "should have valid pid and message - processes-5_1" do
    {pid, ref} = spawn_monitor(ProgrammingElixir.Chapter15, :processExercise5_1, [self()])
    :timer.sleep(500)
    # even after delay we receive message from already shutdown child process
    receive do
      {sender, message} ->
        IO.inspect("pid=#{inspect(pid)} , sender=#{inspect(sender)} , message=#{message}")
        assert pid == sender
        assert message == :testMsg
    end

    # At the end, we receive shutdown/error message
    receive do
      {:DOWN, child_ref, :process, child_pid, error_msg} ->
        IO.inspect(
          "DOWN: pid=#{inspect(pid)} , sender=#{inspect(child_pid)} , message=#{error_msg}"
        )

        assert pid == child_pid
        assert ref == child_ref
        assert error_msg == :exit
    end
  end

  # Exercise: Working with multiple processes-5_2

  test "should have valid pid and message - processes-5_2" do
    {pid, ref} = spawn_monitor(ProgrammingElixir.Chapter15, :processExercise5_2, [self()])
    :timer.sleep(500)
    # even after delay we receive message from already shutdown child process
    receive do
      {sender, message} ->
        IO.inspect("pid=#{inspect(pid)} , sender=#{inspect(sender)} , message=#{message}")
        assert pid == sender
        assert message == :testMsg
    end

    # At the end, we receive shutdown/error message
    receive do
      {:DOWN, child_ref, :process, child_pid, {exception, _stacktrace}} ->
        exception_msg = Exception.message(exception)

        IO.inspect(
          "DOWN: pid=#{inspect(pid)} , sender=#{inspect(child_pid)} , exception_message=#{
            exception_msg
          }"
        )

        assert pid == child_pid
        assert ref == child_ref
        assert "test exception" == exception_msg
    end
  end

  # Exercise: Working with multiple processes-6

  # Exercise: Working with multiple processes-7

  test "Parallel map test" do
    mapper = fn n -> n * n end
    list = 1..100
    expected_result = Enum.map(list, mapper)
    assert Chapter15.pmap(list, mapper) == expected_result
  end

  # Exercise: Working with multiple processes-8

  # no assertion
  test "no test - fib" do
    to_process = List.duplicate(37, 20)

    Enum.each(1..1, fn num_processes ->
      {time, result} =
        :timer.tc(
          Chapter15.Scheduler,
          :run,
          [num_processes, Chapter15.FibSolver, :fib, to_process]
        )

      if num_processes == 1 do
        IO.puts(inspect(result))
        IO.puts("\n # time (s)")
      end

      :io.format("~2B ~.2f~n", [num_processes, time / 1_000_000.0])
    end)
  end

  # no assertion
  test "no test - file", fixture do
    number_of_files = fixture.number_of_files
    token = fixture.token
    {:ok, path} = Briefly.create(directory: true)

    Enum.each(1..number_of_files, fn n ->
      File.write!(Path.join(path, "test#{n}.txt"), "#{token} #{token}}")
    end)

    to_process =
      Enum.map(1..number_of_files, fn n ->
        "#{path}/test#{n}.txt"
      end)

    Enum.each(1..1, fn num_processes ->
      {time, result} =
        :timer.tc(
          Chapter15.SchedulerExercise9,
          :run,
          [num_processes, Chapter15.ProcessorExercise9, :processor, to_process, token]
        )

      if num_processes == 1 do
        IO.puts(inspect(result))
        IO.puts("\n # time (s)")
      end

      :io.format("~2B ~.2f~n", [num_processes, time / 1_000_000.0])
    end)
  end
end
