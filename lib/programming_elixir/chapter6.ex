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
  def sum(n), do: n + sum(n - 1)

  # Exercise modulesAndFunctions-5

  def gcd(x, 0), do: x
  def gcd(x, y), do: y |> gcd(rem(x, y))

  # Exercise modulesAndFunctions-6

  def guess(actual, range) when is_map(range) do
    a..b = range
    actual |> helper(div(b - a + 1, 2), a..b)
  end

  def helper(actual, current_guess, _a..b) when actual > current_guess do
    "Is it #{current_guess}" |> IO.puts()
    actual |> helper(div(b + current_guess, 2), current_guess..b)
  end

  def helper(actual, current_guess, a.._b) when actual < current_guess do
    "Is it #{current_guess}" |> IO.puts()
    actual |> helper(div(current_guess - a, 2) + a, a..current_guess)
  end

  def helper(actual, current_guess, _a.._b) when actual == current_guess do
    "It is #{current_guess}" |> IO.puts()
    current_guess
  end
end
