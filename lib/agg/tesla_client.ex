defmodule Agg.TeslaClient do
  use Tesla

  @base_url Application.get_env(:agg, :umm_base_url, "http://localhost:4000")

  plug Tesla.Middleware.BaseUrl, @base_url
  plug Tesla.Middleware.JSON
end
