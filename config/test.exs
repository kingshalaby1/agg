import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :agg, AggWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "hDB+tM3aUg2mz3e1LQ6WZipDuBsba9yUY5uCnyupe8O698B8Ao5Q8e+/5+xYIWxp",
  server: false

# In test we don't send emails
config :agg, Agg.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
