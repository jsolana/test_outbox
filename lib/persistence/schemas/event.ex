defmodule TestOutbox.Persistence.Schemas.Event do
  @moduledoc """
  Represents the event schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: String.t(),
          event_type: String.t(),
          payload: String.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "events" do
    field(:event_type, :string)
    field(:payload, :string)
    timestamps()
  end

  @updatable_fields ~w(
  event_type
  payload
  )a

  @require_fields ~w(
  event_type
  payload
  )a

  def changeset(event, fields \\ %{}) do
    event
    |> cast(fields, @updatable_fields)
    |> validate_required(@require_fields)
  end
end
