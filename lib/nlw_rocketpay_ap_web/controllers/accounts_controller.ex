defmodule NlwRocketpayApWeb.AccountsController do
  use NlwRocketpayApWeb, :controller
  alias NlwRocketpayAp.Account

  action_fallback NlwRocketpayApWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- NlwRocketpayAp.deposit(params) do
      conn
      |> put_status(:created)
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
end