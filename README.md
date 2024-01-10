# TestOutbox

A dummy example using [outbox](https://github.com/jsolana/outbox) library.
It shows how to provide outbox features following the instructions of the library:

Add `:outbox` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:outbox, "~> 0.1"}
  ]
end
```

Then, you must define an outbox module, associated with the Repo of your application:

```elixir
defmodule TestOutbox.MyOutbox do
  use Outbox, repo: TestOutbox.Repo, publisher: TestOutbox.Publisher.Console

  # Optional, encodes the body of the message to string representation.
  #def encode(body) do
  #  Jason.encode!(body)
  #end
end
```

Finally, you should start the `Outbox` instance in your supervision tree.
For example:

```elixir
defmodule TestOutbox.Application do
  def start(_type, _args) do
    children = [
      TestOutbox.Repo,
      TestOutbox.MyOutbox,
      ...
    ]
  end
end
```

Done! Now you can publish messages!. Try it out with:

```elixir
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
```

You can use Postman to create events and see how they are propagating using outbox pattern :)

## Getting started

You can compile and build the solution running:

```bash
    mix do deps.get, deps.compile, compile
```

To run the service:

1. Execute the follow in a terminal to up & run a Mysql 8 or PostgreSQL* database required by the service

```bash
    # First, start the database using the provided docker-compose.yml
    docker-compose up -d

    # Then, start the service
    mix run --no-halt

    # Or alternatively, to start with Elixir's interactive shell
    iex -S mix
```

**Note**: *Outbox is compatible with MySQL and PostgreSQL.
