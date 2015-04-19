defmodule Abacus.Memory do

  def new(bytes) do
    :memory = :ets.new :memory, [
      :named_table, :public,
      {:read_concurrency, true}, {:write_concurrency, false}
    ]
    load bytes, 0
  end

  def peek(n) do
    case :ets.lookup :memory, n do
      [{n, v}] -> v
      _ -> 0
    end
  end

  def poke(n, byte) do
    true = :ets.insert :memory, {n, byte}
    :ok
  end

  defp load([], _total) do
    :ok
  end

  defp load([b|rest], total) do
    poke total, b
    :ok = load rest, (total + 1)
  end
end
