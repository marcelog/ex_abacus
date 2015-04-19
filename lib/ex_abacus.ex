defmodule Abacus do
  alias Abacus.Memory, as: Memory
  alias Abacus.CPU, as: CPU

  def new(bytes, pc, a) when is_list(bytes) do
    Memory.new bytes
    CPU.new pc, a
  end

  def new(file, pc, a) do
    bytes = to_char_list(File.read! file)
    new bytes, pc, a
  end

  def dump(file) do
    mem = Enum.map (1..65535), fn(n) -> Memory.peek n end
    File.write! file, mem
  end

  def run(cpu) do
    CPU.run cpu
  end
end
