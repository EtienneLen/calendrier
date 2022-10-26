defmodule Calendrier.Repo do
  use Ecto.Repo,
    otp_app: :calendrier,
    adapter: Ecto.Adapters.Postgres
end
