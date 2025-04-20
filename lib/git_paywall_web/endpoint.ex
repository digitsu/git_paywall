defmodule GitPaywallWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :git_paywall
  
  plug Plug.RequestId
  plug Plug.Logger
  
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason
  
  plug Plug.MethodOverride
  plug Plug.Head
  
  plug GitPaywallWeb.Router
end
