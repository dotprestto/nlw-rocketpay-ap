defmodule NlwRocketpayApWeb.AccountsControllerTest do
  use NlwRocketpayApWeb.ConnCase, async: true
  alias NlwRocketpayAp.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Allan Presotto",
        age: 20,
        nickname: "prestto_",
        email: "prestto@gmail.com",
        password: "123456"
      }

      {:ok, %User{account: %Account{id: account_id}}} = NlwRocketpayAp.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOjEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make a deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id},
        "message" => "Balance changed successfully"
      } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid deposit value!"}
      assert expected_response == response
    end
  end
end
