defmodule TestOutbox.Persistence.Repository do
  @moduledoc """
  This module is the ECTO repository for the persistence layer.
  """
  use Ecto.Repo,
    otp_app: :test_outbox,
    # adapter: Ecto.Adapters.Postgres

    adapter: Ecto.Adapters.MyXQL
end
