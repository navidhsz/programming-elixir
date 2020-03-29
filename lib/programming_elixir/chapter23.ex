defmodule ProgrammingElixir.Chapter23 do
  @moduledoc false

  # Exercise: LinkingModules-BehavioursAndUse-1

  defmodule Tracer do
    def dump_args(args) do
      args |> Enum.map(&inspect/1) |> Enum.join(", ")
    end

    def dump_defn(name, args) do
      "#{name}(#{dump_args(args)})"
    end

    # Exercise: LinkingModules-BehavioursAndUse-3
    defmacro def(definition = {:when, _, [{name, _, args}, _cond]}, do: content) do
      quote do
        Kernel.def unquote(definition) do
          IO.puts(inspect(unquote(args)))
          IO.puts("=> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
          result = unquote(content)
          IO.puts("<== result: #{result}")
          result
        end
      end
    end

    defmacro def(definition = {name, _, args}, do: content) do
      quote do
        Kernel.def unquote(definition) do
          IO.puts(inspect(unquote(args)))
          IO.puts("==> call: #{Tracer.dump_defn(unquote(name), unquote(args))}")
          result = unquote(content)
          IO.puts("<== result: #{result}")
          result
        end
      end
    end

    defmacro __using__(_opts) do
      quote do
        import Kernel, except: [def: 2]
        import unquote(__MODULE__), only: [def: 2]
      end
    end
  end

  defmodule Test do
    use Tracer
    def puts_sum_three(a, b, c), do: IO.inspect(a + b + c)
    def add_list(list), do: Enum.reduce(list, 0, &(&1 + &2))

    # Exercise: LinkingModules-BehavioursAndUse-3
    def func_with_guard(a, b, c) when a > 0, do: a + b + c
  end

  # Exercise: LinkingModules-BehavioursAndUse-2
  # explained in https://github.com/elixir-lang/elixir/blob/master/lib/elixir/lib/io/ansi.ex

  defmodule Exercise2 do
    import IO.ANSI

    def print() do
      IO.puts(["Hello, ", white(), green_background(), "world!"])
    end
  end
end
