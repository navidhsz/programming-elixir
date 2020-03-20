defmodule ProgrammingElixir.Chapter17 do
  @moduledoc false

  defmodule Server do
    use GenServer

    def init(initial_number) do
      {:ok, initial_number}
    end

    def handle_call(:next_number, _from, current_number) do
      {:reply, current_number, current_number + 1}
    end

    def handle_call(:prev_number, _from, current_number) do
      {:reply, current_number, current_number - 1}
    end

    def handle_cast({:increment_number, delta}, current_number) do
      {:noreply, current_number + delta}
    end
  end

  # Exercise: OTP-Server-1
  #           OTP-Server-2
  #           OTP-Server-3 (the name is :stack and specified in test)
  #           OTP-Server-4
  #           OTP-Server-5

  defmodule Stack do
    use GenServer

    @stack ProgrammingElixir.Chapter17.Stack

    def create(initial_stack_values, name) do
      GenServer.start_link(@stack, initial_stack_values, name: name)
    end

    def pop(name) do
      GenServer.call(name, :pop)
    end

    def push(value, name) do
      GenServer.cast(name, {:push, value})
    end

    def init(initial_stack_values) do
      {:ok, initial_stack_values}
    end

    def handle_call(:pop, _from, []) do
      raise "cannot pop from empty stack"
    end

    def handle_call(:pop, _from, initial_stack_values) do
      [head | tail] = initial_stack_values
      {:reply, head, tail}
    end

    def handle_cast({:push, []}, initial_stack_values) do
      {:noreply, [initial_stack_values]}
    end

    def handle_cast({:push, new_value}, initial_stack_values) do
      {:noreply, [new_value | initial_stack_values]}
    end

    def terminate(reason, state) do
      IO.puts(inspect(reason))
      Process.exit(self(), :normal)
    end
  end
end
