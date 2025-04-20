defmodule GitPaywallWeb.Router do
  use Phoenix.Router
  
  pipeline :api do
    plug :accepts, ["json"]
  end
  
  scope "/api", GitPaywallWeb do
    pipe_through :api
    
    get "/repos/:repo_id", RepoController, :get
    get "/repos/:repo_id/clone", RepoController, :clone
    post "/repos/:repo_id/price", RepoController, :set_price
  end
  
  # Git protocol handler - this would be implemented differently in production
  # as it would need to handle the Git smart protocol
  scope "/git", GitPaywallWeb do
    get "/:repo_id", GitController, :serve
  end
end
