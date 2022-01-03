defmodule TobaccosClubWeb.VersionController do
  use TobaccosClubWeb, :controller

  def index(conn, _params) do
    text(conn, "The version is #{TobaccosClub.MixProject.project()[:version]}")
  end
end
