defmodule ProgrammingElixir.Chapter24Test do
  use ExUnit.Case

  alias ProgrammingElixir.Chapter24

  @moduletag :capture_log

  doctest Chapter24

  # Exercise: Protocols-1

  test "Caesar cypher for String" do
    assert Chapter24.Caesar.encrypt("abc", 1) == "bcd"
  end

  test "Caesar cypher for charlist" do
    assert Chapter24.Caesar.encrypt('abc', 1) == 'bcd'
  end

  test "Caesar cypher for List" do
    assert Chapter24.Caesar.encrypt([1, 2, 3], 1) == [2, 3, 4]
  end

  test "Caesar cypher for Binary" do
    assert Chapter24.Caesar.encrypt(<<1, 2, 3>>, 1) == <<2, 3, 4>>
  end

  # Exercise: Protocols-2

  test "exercise 2 rot13(abc) = nop" do
    path = Path.expand("data/british-proper-names.95", ".")
    {:ok, data} = File.read(path)
    data_list = data |> String.split("\n", trim: true)

    assert data_list
           |> Enum.map(&Chapter24.Caesar.rot13/1)
           |> Enum.filter(&Enum.member?(data_list, &1)) == ["nop"]
  end
end
