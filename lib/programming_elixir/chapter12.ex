defmodule ProgrammingElixir.Chapter12 do
  @moduledoc false

  # Exercise: ControlFlow-1 ,2

  # In the game of FizzBuzz, children count up from 1. If the number is a multiple of three, they say “Fizz.”
  # For multiples of five, they say “Buzz.” For multiples of both, they say “FizzBuzz.” Otherwise, they say the number.

  def fizzbuzz(n) do
    case {n, rem(n, 3), rem(n, 5)} do
      {_, 0, 0} -> "FizzBuzz"
      {_, 0, _} -> "Fizz"
      {_, _, 0} -> "Buzz"
      {n, _, _} -> n
    end
  end

  # Exercise: ControlFlow-3

  def ok!(pram) do
    ok(pram)
  end

  defp ok({:ok, data}) do
    data
  end

  defp ok(pram) do
    raise RuntimeError, message: "error #{inspect(pram)}"
  end
end
