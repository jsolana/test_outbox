defmodule TestOutbox.Types.Event do
  @moduledoc false
  @type t :: %__MODULE__{
          id: String.t(),
          event_type: String.t(),
          payload: any(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  defstruct [
    :id,
    :event_type,
    :payload,
    :inserted_at,
    :updated_at
  ]
end
