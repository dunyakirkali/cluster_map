defmodule ClusterMap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = [
      example: [
        strategy: Cluster.Strategy.Epmd,
        config: [hosts: [:"dkirkali@127.0.0.1", :"pi@192.168.86.70"]],
      ]
    ]
    children = [
      {Cluster.Supervisor, [topologies, [name: ClusterMap.ClusterSupervisor]]},
    ]

    opts = [strategy: :one_for_one, name: ClusterMap.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
