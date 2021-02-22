defmodule NlwRocketpayApWeb.WelcomeController do
  use NlwRocketpayApWeb, :controller


  def index(conn, _params) do
    text(conn, "Welcome to the Rocketpay API!")
  end
end
