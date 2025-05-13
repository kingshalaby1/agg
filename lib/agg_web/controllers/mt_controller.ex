defmodule AggWeb.MTController do
  use AggWeb, :controller

  def create(conn, %{"sleep_for_ms" => ms} = body) do
    :timer.sleep(ms)

    dlr_body =
      body
      |> Map.put("status", "delivered")
      |> Map.put("delivered_at", DateTime.utc_now())

    Agg.TeslaClient.post("/dlr", dlr_body)

    send_resp(conn, 200, "sent")
  end
end
