defmodule GitPaywall.MixProject do
  use Mix.Project

  def project do
    [
      app: :git_paywall,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GitPaywall.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.2"},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, "~> 0.15"},
      {:httpoison, "~> 1.8"},
      {:bsv, "~> 2.1"} # This is a placeholder, you'd need a real BSV library
    ]
  end
end
