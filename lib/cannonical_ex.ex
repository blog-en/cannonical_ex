defmodule CannonicalEx do
  @moduledoc """
  Documentation for `CannonicalEx`.
  """

  def hello do
    Process.whereis(:redix)
    |> Redix.command(["HGET", "client_1", "key_1"])
    |> elem(1)
    |> Jason.decode!()
  end
end
