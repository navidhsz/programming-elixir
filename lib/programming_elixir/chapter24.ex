defmodule ProgrammingElixir.Chapter24 do
  @moduledoc false

  defmodule My do
    defmacro unless(condition, clauses) do
      do_clause = Keyword.get(clauses, :do, nil)
      else_clause = Keyword.get(clauses, :else, nil)

      quote do
        if unquote(condition) do
          unquote(else_clause)
        else
          unquote(do_clause)
        end
      end
    end
  end
end
