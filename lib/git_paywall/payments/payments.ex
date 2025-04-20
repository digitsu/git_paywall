defmodule GitPaywall.Payments do
  @moduledoc """
  Handles payment verification using Bitcoin SV
  """
  
  alias GitPaywall.BSV.Explorer
  alias GitPaywall.BSV.Wallet
  
  def check_status(user_id, repo_id) do
    repo_payment_address = Wallet.get_payment_address(repo_id)
    
    with {:ok, transactions} <- Explorer.get_address_history(repo_payment_address),
         {:ok, user_transactions} <- filter_user_transactions(transactions, user_id),
         payment_amount = calculate_total_paid(user_transactions) do
      {:ok, %{amount: payment_amount, paid: payment_amount > 0}}
    else
      error -> error
    end
  end
  
  defp filter_user_transactions(transactions, user_id) do
    # In a real implementation, this would filter transactions based on user metadata
    # For simplicity, we'll just return all transactions for now
    {:ok, transactions}
  end
  
  defp calculate_total_paid(transactions) do
    Enum.reduce(transactions, 0, fn tx, acc -> 
      acc + tx.amount
    end)
  end
  
  def record_payment(user_id, repo_id, txid, amount) do
    # Record payment in the database
    # This is a placeholder for the actual implementation
    {:ok, %{user_id: user_id, repo_id: repo_id, txid: txid, amount: amount}}
  end
end
