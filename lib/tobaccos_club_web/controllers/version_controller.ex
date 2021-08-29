defmodule TobaccosClubWeb.VersionController do
  use TobaccosClubWeb, :controller

  def index(conn, _params) do
    conn
    |> text("The version is #{TobaccosClub.MixProject.project()[:version]}")
  end
end
