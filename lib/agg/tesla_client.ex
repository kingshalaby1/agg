defmodule Agg.TeslaClient do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://umm-alb-1438641624.us-east-1.elb.amazonaws.com"
  plug Tesla.Middleware.JSON
end