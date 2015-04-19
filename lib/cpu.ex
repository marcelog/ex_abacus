defmodule Abacus.CPU do
  require Logger
  alias Abacus.DU, as: DU
  alias Abacus.EU, as: EU
  alias Abacus.Memory, as: Memory

  def new(pc, a) do
    %{pc: pc, a: a, stop: false}
  end

  def run(state = %{stop: false, pc: pc}) do
    op = Memory.peek pc
    {instruction, length} = DU.decode op
    Logger.debug "#{inspect state.pc} #{instruction}: #{inspect state}"
    state = EU.execute instruction, state
    Logger.debug "Result = #{inspect state}"
    %{state | pc: state.pc + length}
  end
end