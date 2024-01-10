defmodule MyOutbox.Publisher.Console do
  @moduledoc """
  Console consumer implementation
  For testing purpose
  """

  require Logger

  def publish(event) do
    random = Enum.random(1..100)
    Process.sleep(random * 10)

    response =
      if random < 50 do
        :ok
      else
        {:error, "Dummy error processing the event"}
      end

    Logger.debug(
      "#{__MODULE__} Event published with MyOutbox publisher #{inspect(event)}, response: #{inspect(response)}"
    )

    response
  end
end
