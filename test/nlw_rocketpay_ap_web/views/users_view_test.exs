defmodule NlwRocketpayApWeb.UsersViewTest do
  use NlwRocketpayApWeb.ConnCase
  import Phoenix.View

  alias NlwRocketpayAp.{Account, User}

  test "renders create.json" do
    params = %{
      name: "Allan Presotto",
      age: 20,
      nickname: "prestto_",
      email: "prestto@gmail.com",
      password: "123456"
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = NlwRocketpayAp.create_user(params)

    response = render(NlwRocketpayApWeb.UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
        },
        email: "prestto@gmail.com",
        id: user_id,
        name: "Allan Presotto",
        nickname: "prestto_"
      }
    }

    assert expected_response == response
  end
end
