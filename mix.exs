defmodule TripleDes.Mixfile do
  use Mix.Project

  def project do
    [app: :triple_des,
     version: "1.1.0",
     elixir: "~> 1.4",
     description: "TripleDES crypto",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :crypto]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.15.0", only: :dev}
    ]
  end

  defp package do
    [
      name: :triple_des,
      files: ["lib", "mix.exs", "readme*"],
      maintainers: ["Son Thai", "Vuong Thang"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/diepvuongthang/triple_des.git"}
    ]
  end
end
