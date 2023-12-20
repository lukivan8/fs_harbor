defmodule BeHarborWeb.Router do
  use BeHarborWeb, :router
  use Pow.Phoenix.Router

  pipeline :admin do
    plug BeHarborWeb.RoleAuthPlug, :admin
  end

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
    resources "/articles", ArticleController, only: [:show, :create, :update, :delete]
    get "/articles/user/:user_id", ArticleController, :by_user
    get "/auth/me", UserController, :me
  end

  scope "/api", BeHarborWeb do
    pipe_through :api
    resources "/articles", ArticleController, only: [:index]
  end
end
