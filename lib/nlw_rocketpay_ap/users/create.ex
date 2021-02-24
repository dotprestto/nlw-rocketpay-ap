defmodule NlwRocketpayAp.Users.Create do
  alias NlwRocketpayAp.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
