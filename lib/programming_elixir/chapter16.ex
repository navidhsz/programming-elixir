defmodule ProgrammingElixir.Chapter16 do
  @moduledoc false

  # Exercise: Nodes-1
  # executed 'fun = fn -> IO.puts(Enum.join(File.ls!, ",")) end' on two VM Nodes.

  # Exercise: Nodes-2
  # because of below code (client registration) that 2000ms might not be accurate.
  #  receive do
  #       { :register, pid } -> IO.puts "registering #{inspect pid}"

  # Exercise: Nodes-3

  defmodule Ticker do
    # 2 seconds
    @interval 2000
    @name :ticker
    def start do
      pid = spawn(__MODULE__, :generator, [[], []])
      :global.register_name(@name, pid)
    end

    def register(client_pid) do
      send(:global.whereis_name(@name), {:register, client_pid})
    end

    def generator(all_clients, current_clients) do
      receive do
        {:register, pid} ->
          IO.puts("registering #{inspect(pid)}")
          generator(all_clients ++ [pid], current_clients ++ [pid])
      after
        @interval ->
          IO.puts("tick")
          {client, rest} = get_current_client(all_clients, current_clients)
          send_to_client(client)
          generator(all_clients, rest)
      end
    end

    defp get_current_client([], []), do: {[], []}

    defp get_current_client(all_clients, []) do
      [current | rest] = all_clients
      {current, rest}
    end

    defp get_current_client(all_clients, current_clients) do
      [current | rest] = current_clients
      {current, rest}
    end

    def send_to_client([]) do
    end

    def send_to_client(client) do
      send(client, {:tick})
    end
  end

  # --------------
  defmodule Client do
    def start do
      pid = spawn(__MODULE__, :receiver, [])
      Ticker.register(pid)
    end

    def receiver do
      receive do
        {:tick} ->
          IO.puts("tock in client")
          receiver()
      end
    end
  end

  # Exercise: Nodes-4
end
