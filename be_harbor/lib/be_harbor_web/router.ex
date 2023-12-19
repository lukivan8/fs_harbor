defmodule BeHarborWeb.Router do
  use BeHarborWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug BeHarborWeb.APIAuthPlug, otp_app: :be_harbor
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: BeHarborWeb.APIAuthErrorHandler
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/api/auth", BeHarborWeb do
    pipe_through :api

    resources "/register", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end

  scope "/api", BeHarborWeb do
    pipe_through [:api, :api_protected]
    resources("/articles", ArticleController)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:be_harbor, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BeHarborWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
