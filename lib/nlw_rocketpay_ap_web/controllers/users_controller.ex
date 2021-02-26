defmodule NlwRocketpayApWeb.UsersController do
  use NlwRocketpayApWeb, :controller
  alias NlwRocketpayAp.User

  action_fallback NlwRocketpayApWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- NlwRocketpayAp.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end

  end
end
