defmodule CashlWeb.Router do
  use CashlWeb, :router

  import CashlWeb.UserAuth

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_api_user
  end

  pipeline :api_no_auth do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :fetch_current_user
  end


  # Other scopes may use custom stacks.
  scope "/api", CashlWeb do
    pipe_through :api_no_auth

    post "/users/register", UserRegistrationController, :create
    post "/users/log_in", UserSessionController, :create
    delete "/users/log_out", UserSessionController, :delete
  end

  scope "/api", CashlWeb do
    pipe_through :api
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:cashl, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CashlWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes
  #  scope "/", CashlWeb do
  #    pipe_through [:browser, :redirect_if_user_is_authenticated]
  #
  #    get "/users/register", UserRegistrationController, :new
  #    post "/users/register", UserRegistrationController, :create
  #    get "/users/log_in", UserSessionController, :new
  #    post "/users/log_in", UserSessionController, :create
  #    get "/users/reset_password", UserResetPasswordController, :new
  #    post "/users/reset_password", UserResetPasswordController, :create
  #    get "/users/reset_password/:token", UserResetPasswordController, :edit
  #    put "/users/reset_password/:token", UserResetPasswordController, :update
  #  end

  #scope "/", CashlWeb do
  #  pipe_through [:browser, :require_authenticated_user]
  #
  #  get "/users/settings", UserSettingsController, :edit
  #  put "/users/settings", UserSettingsController, :update
  #  get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  #end

  #scope "/", CashlWeb do
  #  pipe_through [:browser]
  #
  #  delete "/users/log_out", UserSessionController, :delete
  #  get "/users/confirm", UserConfirmationController, :new
  #  post "/users/confirm", UserConfirmationController, :create
  #  get "/users/confirm/:token", UserConfirmationController, :edit
  #  post "/users/confirm/:token", UserConfirmationController, :update
  #end
end
