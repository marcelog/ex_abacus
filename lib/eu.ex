defmodule Abacus.EU do
  alias Abacus.Memory, as: Memory
  require Bitwise

  def execute(instruction, state) do
    apply Abacus.EU, instruction, [state]
  end

  # A <- OP
  def load_immediate(state) do
    data = direct state
    %{state | a: data}
  end

  # A <- [OP]
  def load(state) do
    data = indirect state
    %{state | a: data}
  end

  # [OP] <- A
  def store(state) do
    addr = direct state.pc
    Memory.poke addr, state.a
    state
  end

  # A <- A + [OP]
  def add(state) do
    value = indirect state
    # Should do 2's complement?
    %{state | a: state.a + value}
  end

  # !A
  def not_acc(state) do
    %{state | a: Bitwise.bnot state.a}
  end

  # PC <- OP if A == 0
  def jz(state = %{a: 0}) do
    val = direct state
    %{state | pc: val}
  end

  def jz(state = %{a: _}) do
    state
  end

  # PC <- OP if A > 0
  def jaz(state = %{a: a}) do
    if a > 0 do
      val = direct state
      %{state | pc: val}
    else
      state
    end
  end

  # PC <- OP if A < 0
  def jbz(state = %{a: a}) do
    if a < 0 do
      val = direct state
      %{state | pc: val}
    else
      state
    end
  end

  # HALT
  def hlt(state) do
    %{state | stop: true}
  end

  defp direct(state) do
    Memory.peek (state.pc + 1)
  end

  defp indirect(state) do
    addr = Memory.peek (state.pc + 1)
    Memory.peek addr
  end
end