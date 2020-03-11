defmodule ProgrammingElixir.Chapter6 do
  @moduledoc false

  # Exercise modulesAndFunctions-1

  def double(n) do
    n * 2
  end

  def triple(n) do
    n * 3
  end

  # Exercise modulesAndFunctions-2
  # run the module on iex

  # Exercise modulesAndFunctions-3

  def quadruple(n) do
    double(n) * 2
  end

  # Exercise modulesAndFunctions-4

  def sum(0), do: 0
  def sum(n), do: n + sum(n-1)

  # Exercise modulesAndFunctions-5

  def gcd(x,0), do: x
  def gcd(x,y), do: gcd(y,rem(x,y))

end
