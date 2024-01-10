defmodule TestOutbox.Persistence.Event do
  @moduledoc false
  import Ecto.Query

  require Logger

  alias TestOutbox.Persistence.Schemas.Event, as: EventSchema
  alias TestOutbox.Persistence.Repository
  alias TestOutbox.Types.Event, as: EventType
  alias TestOutbox.MyOutbox

  def save_event(event_type, payload) do
    changeset =
      EventSchema.changeset(%EventSchema{}, %{
        event_type: event_type,
        payload: Poison.encode!(payload)
      })

    Repository.transaction(fn ->
      case Repository.insert(changeset) do
        {:ok, event} ->
          MyOutbox.outbox!(event_type, payload)
          event |> cast_event()

        {:error, reason} ->
          Repository.rollback(
            "An error occurrs saving the event #{payload} with type #{event_type}, details: #{inspect(reason)}"
          )
      end
    end)
  end

  defp cast_event(event_schema) do
    %EventType{
      event_type: event_schema.event_type,
      id: event_schema.id,
      payload: event_schema.payload |> Poison.decode!(),
      inserted_at: event_schema.inserted_at,
      updated_at: event_schema.updated_at
    }
  end

  def get_event(id) do
    case Repository.one(
           from(e in EventSchema,
             where: e.id == ^id
           )
         ) do
      nil ->
        Logger.warn("Event with id #{id} Not found")
        {:error, :not_found}

      event = %EventSchema{} ->
        {:ok, event |> cast_event()}

      {:error, reason} ->
        Logger.error("An error ocurrs getting the event id #{id}, details: #{inspect(reason)}")
        {:error, reason}
    end
  end
end
