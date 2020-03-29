defmodule ProgrammingElixir.Chapter24 do
  @moduledoc false

  # Exercise: Protocols-1

  defprotocol Caesar do
    def encrypt(things, shift)
    def rot13(things)
  end

  defimpl Caesar, for: [BitString] do
    def encrypt(things, shift),
      do: List.to_string(Enum.map(String.to_charlist(things), &(&1 + shift)))

    def rot13(things), do: encrypt(things, 13)
  end

  defimpl Caesar, for: [List] do
    def encrypt(things, shift), do: Enum.map(things, &(&1 + shift))
    def rot13(things), do: encrypt(things, 13)
  end
end
