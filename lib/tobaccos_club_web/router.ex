defmodule TobaccosClubWeb.Router do
  use TobaccosClubWeb, :router

  import TobaccosClubWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TobaccosClubWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TobaccosClubWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TobaccosClubWeb.Telemetry
    end

    scope "/dev" do
      pipe_through [:browser]
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Sitemap

  scope "/", TobaccosClubWeb do
    pipe_through :browser
    get "/sitemap.xml", SitemapController, :index
  end

  ## Authentication routes

  scope "/", TobaccosClubWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", TobaccosClubWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", TobaccosClubWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :confirm
  end

  scope "/", TobaccosClubWeb do
    pipe_through :browser
    live "/", BlendsLive.Index, :index
    live "/contact", BlendsLive.Index, :contact
    live("/blends/new", BlendsLive.Index, :new)
    live("/:brand_slug/:blend_slug", BlendsLive.Show, :show)
    live "/brands", BrandsLive.Index
    live "/:brand_slug", BrandsLive.Show
    live "/:brand/:blend_id", Blends.ShowLive, :show
  end

  # Required authentication

  scope "/", TobaccosClubWeb do
    pipe_through [:browser, :require_authenticated_user]

    live("/:brand_slug/:blend_slug/show/edit", BlendsLive.Show, :edit)
  end
end
