defmodule BeHarbor.Repo do
  use Ecto.Repo,
    otp_app: :be_harbor,
    adapter: Ecto.Adapters.Postgres
end
