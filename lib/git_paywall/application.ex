defmodule GitPaywall.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Repo
      {GitPaywall.Repo, []},
      # Endpoint
      {GitPaywallWeb.Endpoint, []}
    ]

    opts = [strategy: :one_for_one, name: GitPaywall.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
