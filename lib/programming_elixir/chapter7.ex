defmodule ProgrammingElixir.Chapter7 do
  @moduledoc false

  # Exercise listAndRecursion-1

  def mapsum([],_func), do: 0

  def mapsum([head | tail],func) do
       func.(head) + mapsum(tail,func)
  end

  # Exercise listAndRecursion-2

  def max(list) do
    [head | list] = list
    maxHelper(list,head)
  end

  defp maxHelper([],currentValue), do: currentValue
  defp maxHelper([head | tail], currentValue) when head != nil and head >= currentValue , do: maxHelper(tail,head)
  defp maxHelper([head | tail], currentValue) when head != nil and head < currentValue , do: maxHelper(tail,currentValue)


  # Exercise listAndRecursion-3

  def caesar(list,n) do
    caesarHelper(list,n)
  end

  defp caesarHelper([],n), do: []
  defp caesarHelper([head | tail],n) when head+n <= ?z, do: [head+n | caesarHelper(tail,n)]
  defp caesarHelper([head | tail],n) when head+n > ?z, do: [head+n-?z+?a-1 | caesarHelper(tail,n)]

  # Exercise listAndRecursion-4

  def span(from,to) when from == to do
    [from]
  end

  def span(from,to) do
    [from | span(from+1,to)]
  end

end
