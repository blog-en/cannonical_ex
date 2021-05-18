defmodule CannonicalExTest do
  use ExUnit.Case
  doctest CannonicalEx

  describe "base module," do

    @data %{ "name" => "Carlos" }

    setup do
      Process.whereis(:redix)
      |> Redix.command(["HSET", "client_1", "key_1", Jason.encode!(@data)])

      :ok
    end

    test "greets the world" do
      assert CannonicalEx.hello() == @data
    end

  end

end
