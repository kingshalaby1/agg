defmodule AggWeb.MTController do
  use AggWeb, :controller

  require Logger

  def create(conn, %{"message_id" => msg_id, "sleep_for_ms" => ms} = params) do
    Task.start(fn ->
      :timer.sleep(ms)
      payload =
        params
        |> Map.put("status_code", 4)
        |> Map.put("delivered_at", DateTime.utc_now() |> DateTime.to_iso8601())

      case Agg.TeslaClient.post("/dlr", payload) do
        {:ok, %Tesla.Env{status: 200}} ->
          Logger.info("DLR sent for #{msg_id}")
        {:ok, %Tesla.Env{status: st}} ->
          Logger.info("DLR sent for #{msg_id} but got status #{st}")  
        {:error, reason} ->
          Logger.error("Failed to send DLR: #{inspect(reason)}")
      end
    end)

    send_resp(conn, 200, "sent")
  end
end
