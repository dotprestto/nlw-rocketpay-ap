defmodule NlwRocketpayApWeb.AccountsController do
  use NlwRocketpayApWeb, :controller
  alias NlwRocketpayAp.Account
  alias NlwRocketpayAp.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback NlwRocketpayApWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- NlwRocketpayAp.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end

  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- NlwRocketpayAp.withdraw(params) do
      conn
      |> put_status(:created)
      |> render("update.json", account: account)
    end

  end

  def transaction(conn, params) do
    task = Task.async(fn -> NlwRocketpayAp.transaction(params) end)
    # Quando não se preocupa com retorno imediato, ex: um email ou gerar relatório
    # Task.start(fn -> NlwRocketpayAp.transaction(params) end)
    with {:ok, %TransactionResponse{} = transaction} <- Task.await(task) do
      conn
      |> put_status(:created)
      |> render("transaction.json", transaction: transaction)
    end

  end
end
