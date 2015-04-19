defmodule Abacus.DU do
  def decode(0x00) do
    {:load_immediate, 2}
  end

  def decode(0x01) do
    {:load, 2}
  end

  def decode(0x02) do
    {:store, 2}
  end

  def decode(0x03) do
    {:add, 2}
  end

  def decode(0x04) do
    {:not_acc, 1}
  end

  def decode(0x05) do
    {:jz, 0}
  end

  def decode(0x06) do
    {:jaz, 0}
  end

  def decode(0x07) do
    {:jbz, 0}
  end

  def decode(0x0F) do
    {:hlt, 0}
  end
end
