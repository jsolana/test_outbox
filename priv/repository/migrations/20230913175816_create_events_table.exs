defmodule TestOutbox.Persistence.Repository.Migrations.CreateEventsTable do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:events, primary_key: true) do
      add(:event_type, :string)
      add(:payload, :string)

      # adds created_at and updated_at
      timestamps()
    end
  end
end
