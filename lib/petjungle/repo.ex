defmodule Petjungle.Repo do
  use Ecto.Repo,
    otp_app: :petjungle,
    adapter: Ecto.Adapters.Postgres
end
