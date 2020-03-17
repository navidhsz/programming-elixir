defmodule ProgrammingElixir.Chapter2 do
  @moduledoc false

  ##### Exercise: patten-matching-1

  # test module has unit test for below

  # a = [1,2,3]   match
  # a = 4     match
  # 4 =a      match
  # [a,b] = [1,2,3] matchError
  # a = [[1,2,3]] match
  # [a] = [[1,2,3]] match
  # [[a]] = [[1,2,3]] matchError

  ##### Exercise: patten-matching-2

  # [a,b,a] = [1,2,3]  matchError
  # [a,b,a] = [1,1,2]  matchError
  # [a,b,a] = [1,2,1]  match

  ##### Exercise: patten-matching-3

  # a = 2
  # [a,b,a] = [1,2,3] matchError
  # [a,b,a] = [1,1,2] matchError
  # a = 1 match
  # ^a = 2 matchError
  # ^a = 1 match
  # ^a = 2 - a match
end
