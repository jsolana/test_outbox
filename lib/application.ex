defmodule TestOutbox.Runtime do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start repository and run db migrations before anything else
      {TestOutbox.Persistence.Supervisor, show_sensitive_data_on_connection_error: false},
      TestOutbox.Endpoint,
      TestOutbox.MyOutbox
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestOutboxSupervisor]
    Supervisor.start_link(children, opts)
  end
end
