defmodule TestOutbox.Router do
  use Plug.Router

  alias TestOutbox.Persistence.Event, as: EventRepository
  require Logger

  plug(:match)
  plug(:dispatch)

  ############################ READINESS  ############################

  get "/status" do
    # Naive health check
    conn
    |> send_resp(200, "")
  end

  ############################ PROCESS EVENT ############################

  get "/events/:id" do
    conn
    |> put_resp_content_type("application/json")
    |> get_event(id)
  end

  defp get_event(conn, id) when is_binary(id) and id != "" do
    Logger.info("Get event with id#{id}")

    case EventRepository.get_event(id) do
      {:ok, event} ->
        Logger.info("Event with id #{id}, details: #{inspect(event)}")
        send_resp(conn, 200, Poison.encode!(event))

      {:error, :not_found} ->
        send_resp(conn, 404, Poison.encode!(%{message: "Not Found"}))

      {:error, reason} ->
        send_resp(conn, 500, Poison.encode!(%{message: inspect(reason)}))
    end
  end

  post "/events" do
    conn
    |> put_resp_content_type("application/json")
    |> process_event(conn.body_params)
  end

  defp process_event(conn, %{"event_type" => event_type, "payload" => payload}) do
    Logger.info("Processing event #{event_type}, payload: #{inspect(payload)}")

    case EventRepository.save_event(event_type, payload) do
      {:ok, event} ->
        Logger.info("Event inserted correctly, details: #{inspect(event)}")
        send_resp(conn, 202, Poison.encode!(event))

      {:error, reason} ->
        send_resp(conn, 500, Poison.encode!(%{message: inspect(reason)}))
    end
  end

  ############################ NOT FOUND ############################

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, "")
  end
end
