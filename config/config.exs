# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nlw_rocketpay_ap,
  ecto_repos: [NlwRocketpayAp.Repo]

# Configures the endpoint
config :nlw_rocketpay_ap, NlwRocketpayApWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dHaFAj39QUBzueP7YeGcsd9OUQvX1eyxKoY8BCYhRg8Yd2BgFgiOkTvyyqTxtMo3",
  render_errors: [view: NlwRocketpayApWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: NlwRocketpayAp.PubSub,
  live_view: [signing_salt: "UIHP75mX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
