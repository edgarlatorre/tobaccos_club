defmodule TobaccosClub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TobaccosClub.Repo,
      # Start the Telemetry supervisor
      TobaccosClubWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TobaccosClub.PubSub},
      # Start the Endpoint (http/https)
      TobaccosClubWeb.Endpoint
      # Start a worker by calling: TobaccosClub.Worker.start_link(arg)
      # {TobaccosClub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TobaccosClub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TobaccosClubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
