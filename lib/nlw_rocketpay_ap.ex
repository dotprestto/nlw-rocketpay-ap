defmodule NlwRocketpayAp do
  alias NlwRocketpayAp.Users.Create, as: UserCreate

  defdelegate create_user, to: UserCreate, as: :call
end
