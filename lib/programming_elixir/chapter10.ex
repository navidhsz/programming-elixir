defmodule ProgrammingElixir.Chapter10 do
  @moduledoc false

  # Exercise listAndRecursion-5

  def all?([], _func), do: true

  def all?([head | tail], func) do
    func.(head) and all?(tail, func)
  end

  def each([], _func), do: :ok

  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []

  def filter([head | []], func) do
    if func.(head) do
      [head]
    else
      []
    end
  end

  def filter([head | tail], func) do
    if func.(head) do
      [head] ++ filter(tail, func)
    else
      filter(tail, func)
    end
  end

  def split([], _n), do: []

  def split(list, n) when n > 0 do
    list |> splitHelper([], n)
  end

  def split(list, n) when n == 0 do
    {[], list}
  end

  defp splitHelper([head | tail], firstList, n) when n > 0 do
    tail |> splitHelper(firstList ++ [head], n - 1)
  end

  defp splitHelper([head | tail], firstList, n) when n == 0 do
    {firstList, [head | tail]}
  end

  def take([], _n), do: []

  def take([head | tail], n) when n > 0 do
    [head | take(tail, n - 1)]
  end

  def take([head | tail], n) when n < 0 do
    [reverseHead | reverseTail] = reverse([head | tail])
    [reverseHead | take(reverse(reverseTail), n + 1)]
  end

  def take([_head | _tail], n) when n == 0 do
    []
  end

  def reverse([]), do: nil
  def reverse([head | []]), do: [head]

  def reverse([head | tail]) do
    reverse(tail) ++ [head]
  end
end
