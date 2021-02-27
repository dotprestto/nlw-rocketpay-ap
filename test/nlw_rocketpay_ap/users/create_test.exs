defmodule NlwRocketpayAp.Users.CreateTest do
  use NlwRocketpayAp.DataCase
  alias NlwRocketpayAp.Users.Create
  alias NlwRocketpayAp.User
  alias NlwRocketpayAp.Repo

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Allan Presotto",
        age: 20,
        nickname: "prestto_",
        email: "prestto@gmail.com",
        password: "123456"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Allan Presotto", age: 20, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Allan Presotto",
        age: 15,
        nickname: "prestto_",
        email: "prestto@gmail.com",
        # password: "123456"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{age: ["must be greater than or equal to 18"], password: ["can't be blank"]}

      assert expected_response == errors_on(changeset)
    end
  end
end
