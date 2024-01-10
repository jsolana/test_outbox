defmodule TestOutbox.Persistence.Supervisor do
  @moduledoc """
  This is a supervisor that starts the repository for the application
  and also ensures database migrations are run on application start
  """
  alias TestOutbox.Persistence.{Repository, Migrator}

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :supervisor
    }
  end

  def start_link(opts) do
    children = [
      %{id: Repository, start: {__MODULE__, :start_repo_and_migrate_up, [opts]}}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  def start_repo_and_migrate_up(opts) do
    with {:ok, pid} <- Repository.start_link(opts) do
      Migrator.up()
      {:ok, pid}
    end
  end
end
