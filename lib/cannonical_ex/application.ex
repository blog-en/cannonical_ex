defmodule CannonicalEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Vapor.Provider.{Env, Dotenv}

  @impl true
  def start(_type, _args) do

    providers = [
      # https://hexdocs.pm/vapor/Vapor.Provider.Dotenv.html
      %Dotenv{overwrite: true},
      %Env{
        bindings: [
          redis_port: "REDIS_PORT",
          redis_host: "REDIS_HOST",
        ]
      },
      # %Dotenv{filename: "/path/to/file/.env"},
    ]

    # If values could not be found we raise an exception and halt the boot process
    config = Vapor.load!(providers)
    children = [
      {
        Redix,
        host: config.redis_host,
        name: :redix,
        port: config.redis_port
              |> String.to_integer()
      },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CannonicalEx.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
