defmodule CellularSample.Worker do
  require Logger

  @url "http://beam.soracom.io:8888/"
  @headers [{"Content-Type", "application/json"}]

  def run do
    {:ok, {temperature, humidity}} = CellularSample.Aht20.read()

    inspect({temperature, humidity}) |> Logger.debug()

    post(temperature, humidity)
  end

  defp post(temperature, humidity) do
    time = Timex.now() |> Timex.to_unix()
    json = Jason.encode!(%{value: %{temperature: temperature, humidity: humidity, time: time}})
    HTTPoison.post(@url, json, @headers)
  end
end
