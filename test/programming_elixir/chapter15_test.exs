defmodule ProgrammingElixir.Chapter15Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter15

  @moduletag :capture_log

  doctest Chapter15

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
end
