import Config

config :test_outbox, TestOutbox.Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4000")

config :test_outbox,
  ecto_repos: [TestOutbox.Persistence.Repository]

# Defaults for database connection
config :test_outbox, TestOutbox.Persistence.Repository,
  database: "test_outbox_dev",
  username: "root",
  password: "root",
  hostname: "localhost"

# Configures Elixir's Logger
config :logger, :console,
  level: :debug,
  format: "$time $metadata[$level] $message\n"
