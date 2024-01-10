defmodule TestOutbox.Persistence.Migrator do
  @moduledoc """
  Module to run database migrations
  """
  require Logger

  def up do
    Logger.info("Running database migrations up")

    Ecto.Migrator.run(
      TestOutbox.Persistence.Repository,
      Path.join(["#{:code.priv_dir(:test_outbox)}", "repository", "migrations"]),
      :up,
      all: true
    )
  end
end
