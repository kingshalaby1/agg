defmodule AggWeb.MTController do
  use AggWeb, :controller
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://umm-alb-1438641624.us-east-1.elb.amazonaws.com"
  plug Tesla.Middleware.JSON

  def create(conn, %{"sleep_for_ms" => ms} = body) do
    :timer.sleep(ms)

    dlr_body =
      body
      |> Map.put("status", "delivered")
      |> Map.put("delivered_at", DateTime.utc_now())

    post("/dlr", dlr_body)

    send_resp(conn, 200, "sent")
  end
end
