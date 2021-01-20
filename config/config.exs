# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :wino_api,
  ecto_repos: [WinoApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :wino_api, WinoApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PrE/m6pziE1w7DrvU54JzqrsHUwVte764DaUTblTCIsxo8wSVT76I/rApjQVeWvH",
  render_errors: [view: WinoApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: WinoApi.PubSub,
  live_view: [signing_salt: "71rxzovs"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
