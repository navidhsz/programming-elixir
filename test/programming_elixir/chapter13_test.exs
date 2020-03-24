defmodule ProgrammingElixir.Chapter13Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter13

  @moduletag :capture_log

  doctest Chapter13

  # Exercise: OrganizingAProject-1

  import ProgrammingElixir.Chapter13.Issues.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", 99]) == {"user", "project", 99}
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end
end
