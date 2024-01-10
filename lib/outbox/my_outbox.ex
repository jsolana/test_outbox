defmodule TestOutbox.MyOutbox do
  @moduledoc false
  use Outbox, repo: TestOutbox.Persistence.Repository, publisher: MyOutbox.Publisher.Console

  require Logger

  # def encode(body) do
  #  Poison.encode!(body)
  # end
end
