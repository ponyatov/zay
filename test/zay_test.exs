defmodule ZayTest do
  use ExUnit.Case
  doctest Zay

  test "hello" do
    assert Zay.hello() == :world
  end

  test "erlang" do
    assert :zay.init() == :ok
  end
end
