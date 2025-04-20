defmodule GitPaywall.AccessControl do
  @moduledoc """
  Handles repository access control based on payment verification
  """
  
  alias GitPaywall.Repositories
  alias GitPaywall.Payments
  alias GitPaywall.BSV.Wallet
  
  def verify_access(repo_id, user_id) do
    with {:ok, repo} <- Repositories.get(repo_id),
         {:ok, payment_status} <- Payments.check_status(user_id, repo_id),
         :ok <- validate_payment(payment_status, repo.price) do
      {:ok, generate_access_token(user_id, repo_id)}
    else
      {:error, :payment_required} -> 
        payment_address = Wallet.generate_payment_address(repo_id)
        {:error, :payment_required, %{address: payment_address, amount: repo.price}}
      error -> error
    end
  end
  
  defp validate_payment(payment_status, required_amount) do
    if payment_status.amount >= required_amount do
      :ok
    else
      {:error, :payment_required}
    end
  end
  
  defp generate_access_token(user_id, repo_id) do
    # Generate temporary access token for the repository
    token = :crypto.strong_rand_bytes(32) |> Base.encode16(case: :lower)
    
    # In a production system, you would store this token with an expiration
    # For now, we'll just return it
    token
  end
end
