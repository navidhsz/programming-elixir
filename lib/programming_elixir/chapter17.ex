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

  # Exercise: OTP-Server-1 , OTP-Server-2

  defmodule Stack do
    use GenServer

    def init(initial_stack_values) do
      {:ok, initial_stack_values}
    end

    def handle_call(:pop, _from, []) do
      Process.exit(self(), :normal)
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
  end
end
