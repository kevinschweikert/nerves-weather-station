defmodule WeatherStation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WeatherStation.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: WeatherStation.Worker.start_link(arg)
        # {WeatherStation.Worker, arg},

      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: WeatherStation.Worker.start_link(arg)
      # {WeatherStation.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: WeatherStation.Worker.start_link(arg)
      # {WeatherStation.Worker, arg},
      {BMP280, [bus_name: "i2c-1", bus_address: 0x76, name: BMP280]}
    ]
  end

  def target() do
    Application.get_env(:weather_station, :target)
  end
end
