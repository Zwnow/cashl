defmodule Cashl.Repo do
  use Ecto.Repo,
    otp_app: :cashl,
    adapter: Ecto.Adapters.Postgres
end
