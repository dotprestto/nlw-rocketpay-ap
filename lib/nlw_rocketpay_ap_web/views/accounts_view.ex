defmodule NlwRocketpayApWeb.AccountsView do
  alias NlwRocketpayAp.Account

  def render("update.json", %{
      account: %Account{id: id, balance: balance}
    }) do
    %{
      message: "Balance changed successfully",
      account: %{
        id: id,
        balance: balance
      }
    }
  end
end
