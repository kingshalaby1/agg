defmodule Agg.TeslaClient do
  use Tesla

  plug Tesla.Middleware.BaseUrl, Application.compile_env!(:agg, Agg.TeslaClient)[:base_url]
  plug Tesla.Middleware.JSON
end
