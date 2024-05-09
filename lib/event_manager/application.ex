defmodule EventManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EventManagerWeb.Telemetry,
      EventManager.Repo,
      {DNSCluster, query: Application.get_env(:event_manager, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EventManager.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EventManager.Finch},
      # Start a worker by calling: EventManager.Worker.start_link(arg)
      # {EventManager.Worker, arg},
      # Start to serve requests, typically the last entry
      EventManagerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EventManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
