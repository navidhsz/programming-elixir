defmodule ProgrammingElixir.Chapter22 do
  @moduledoc false

  # Exercise: MacrosAndCodeEvaluation-1

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

  # Exercise: MacrosAndCodeEvaluation-2

  defmodule Times do
    defmacro times_n(param) do
      name = String.to_atom("times_#{param}")

      quote do
        def times(n) do
          n * unquote(param)
        end
      end
      |> update_func_name(name)
    end

    defp update_func_name(func, new_name) do
      new_name_tuple = func |> elem(2) |> Enum.at(0) |> put_elem(0, new_name)
      new_name_list = List.update_at(func |> elem(2), 0, fn _ -> new_name_tuple end)
      put_elem(func, 2, new_name_list)
    end
  end

  defmodule TestExercise2 do
    require ProgrammingElixir.Chapter22.Times
    ProgrammingElixir.Chapter22.Times.times_n(3)
    ProgrammingElixir.Chapter22.Times.times_n(4)
  end

  # Sample output when quoting function, function name can be accessed on name_list=elem(func,2) which returns a list
  # Then name=Enum.at(name_list,0) return a tuple which has function name on first element
  # update name: put_elem(list,new_name,0)

  #  {:def, [context: ProgrammingElixir.Chapter22.Times, import: Kernel],
  #    [
  #      {:times, [context: ProgrammingElixir.Chapter22.Times],
  #        [{:n, [], ProgrammingElixir.Chapter22.Times}]},
  #      [
  #        do: {:*, [context: ProgrammingElixir.Chapter22.Times, import: Kernel],
  #          [{:n, [], ProgrammingElixir.Chapter22.Times}, 3]}
  #      ]
  #    ]}
end
