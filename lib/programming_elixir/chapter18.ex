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

      if head == "kill" do
        raise "kill stack process"
      end

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

  # -------------------------
  # Exercise: OTP-Supervisors-2

  defmodule StackAppWithStash do
    def start(args) do
      children = [
        {ProgrammingElixir.Chapter18.Stash, []},
        {ProgrammingElixir.Chapter18.StackWithStash, args}
      ]

      opts = [strategy: :rest_for_one, name: __MODULE__]
      Supervisor.start_link(children, opts)
    end
  end

  defmodule Stash do
    use GenServer

    @stash __MODULE__

    @impl true
    # ignore the state passed from client and use from stash
    def init(init_state) do
      {:ok, init_state}
    end

    def start_link(state) do
      GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    def get() do
      GenServer.call(@stash, {:get})
    end

    def update(new_state) do
      GenServer.cast(@stash, {:update, new_state})
    end

    @impl true
    def handle_call({:get}, _from, initial_stack_values) do
      {:reply, initial_stack_values, initial_stack_values}
    end

    @impl true
    def handle_cast({:update, new_state}, _old_state) do
      {:noreply, new_state}
    end
  end

  defmodule StackWithStash do
    use GenServer

    def start_link(state) do
      GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    # callbacks

    @impl true
    # ignore the state passed from client and use from stash
    def init(_) do
      {:ok, ProgrammingElixir.Chapter18.Stash.get()}
    end

    @impl true
    def handle_call(:pop, _from, []) do
      raise "cannot pop from empty stack"
    end

    @impl true
    def handle_call(:pop, _from, initial_stack_values) do
      [head | tail] = initial_stack_values

      if head == "kill" do
        ProgrammingElixir.Chapter18.Stash.update(tail)
        # emulate process crash
        raise "kill stack process"
      end

      ProgrammingElixir.Chapter18.Stash.update(tail)
      {:reply, head, tail}
    end

    @impl true
    def handle_cast({:push, []}, initial_stack_values) do
      ProgrammingElixir.Chapter18.Stash.update([initial_stack_values])
      {:noreply, [initial_stack_values]}
    end

    @impl true
    def handle_cast({:push, new_value}, initial_stack_values) do
      ProgrammingElixir.Chapter18.Stash.update([new_value | initial_stack_values])
      {:noreply, [new_value | initial_stack_values]}
    end

    @impl true
    def terminate(reason, state) do
      Process.exit(self(), :normal)
    end
  end
end
