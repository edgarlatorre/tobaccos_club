defmodule TobaccosClub.Repo do
  use Ecto.Repo,
    otp_app: :tobaccos_club,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 100
end
