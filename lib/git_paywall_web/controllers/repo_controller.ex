defmodule GitPaywallWeb.RepoController do
  use GitPaywallWeb, :controller
  
  alias GitPaywall.AccessControl
  
  def clone(conn, %{"repo_id" => repo_id}) do
    user_id = get_user_id(conn)
    
    case AccessControl.verify_access(repo_id, user_id) do
      {:ok, access_token} ->
        # Redirect to Git endpoint with access token
        conn
        |> put_resp_header("Location", "/git/#{repo_id}?token=#{access_token}")
        |> send_resp(302, "")
        
      {:error, :payment_required, payment_info} ->
        # Return HTTP 402 with payment details
        conn
        |> put_status(402)
        |> put_resp_header("X-Payment-Address", payment_info.address)
        |> put_resp_header("X-Payment-Amount", to_string(payment_info.amount))
        |> json(%{
          message: "Payment required to access this repository",
          payment_address: payment_info.address,
          amount: payment_info.amount,
          currency: "BSV"
        })
        
      {:error, _reason} ->
        conn
        |> put_status(403)
        |> json(%{error: "Access denied"})
    end
  end
  
  defp get_user_id(conn) do
    # Extract user ID from authentication token
    # This is just a placeholder
    conn.assigns[:user_id] || "anonymous"
  end
end
