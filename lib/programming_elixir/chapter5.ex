defmodule ProgrammingElixir.Chapter5 do
  @moduledoc false

  # Exercise function-1
  # lets mix anonymous function with named function

  def list_concat(x, y) do
    list_concat = fn x, y -> x ++ y end
    list_concat.(x, y)
  end

  def sum(x, y, z) do
    sum = fn x, y, z -> x + y + z end
    sum.(x, y, z)
  end

  def pair_tuple_to_list({x, y}) do
    pair_tuple_to_list = fn {x, y} -> [x, y] end
    pair_tuple_to_list.({x, y})
  end

  # Exercise function-2

  def fizz_buzz(a, b, c) do
    (fn
       0, 0, _ -> "FizzBuzz"
       0, _, _ -> "Fizz"
       _, 0, _ -> "Buzz"
       _, _, c -> c
     end).(a, b, c)
  end

  # Exercise function-3

  def exercise3(n) do
    fizz_buzz(rem(n, 3), rem(n, 5), n)
  end

  # Exercise function-4

  def prefix(str1) do
    (fn str1 ->
       fn
         str2 -> "#{str1} #{str2}"
       end
     end).(str1)
  end

  # Exercise function-5

  def map(lst) do
    Enum.map(lst, &(&1 + 2))
  end

  def each(lst) do
    Enum.each(lst, &IO.inspect(&1))
  end
end
