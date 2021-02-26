defmodule NlwRocketpayApWeb.UsersView do
  alias NlwRocketpayAp.{User, Account}

  def render("create.json", %{
      user: %User{account: %Account{id: account_id, balance: balance}, email: email, id: id, name: name, nickname: nickname}
    }) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        email: email,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end
end
