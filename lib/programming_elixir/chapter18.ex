defmodule ProgrammingElixir.Chapter18 do
  @moduledoc false

  # Exercise: OTP-Supervisors-1

  defmodule StackApp do
    def start(args) do
      children = [
        {ProgrammingElixir.Chapter18.Stack, args}
      ]

      opts = [strategy: :one_for_one, name: __MODULE__]
      Supervisor.start_link(children, opts)
    end
  end

  defmodule Stack do
    use GenServer

    def start_link(state) do
      GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    # callbacks

    @impl true
    def init(initial_stack_values) do
      {:ok, initial_stack_values}
    end

    @impl true
    def handle_call(:pop, _from, []) do
      raise "cannot pop from empty stack"
    end

    @impl true
    def handle_call(:pop, _from, initial_stack_values) do
      [head | tail] = initial_stack_values
      {:reply, head, tail}
    end

    @impl true
    def handle_cast({:push, []}, initial_stack_values) do
      {:noreply, [initial_stack_values]}
    end

    @impl true
    def handle_cast({:push, new_value}, initial_stack_values) do
      {:noreply, [new_value | initial_stack_values]}
    end

    @impl true
    def terminate(reason, state) do
      Process.exit(self(), :normal)
    end
  end
end
