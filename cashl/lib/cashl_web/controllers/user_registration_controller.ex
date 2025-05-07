defmodule CashlWeb.UserRegistrationController do
  use CashlWeb, :controller

  alias Cashl.Accounts
  alias Cashl.Accounts.User
  alias CashlWeb.UserAuth

  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        conn
        |> send_resp(201, Jason.encode!(%{status: "success"}))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def create(conn, _) do
    conn
    |> send_resp(400, Jason.encode!(%{status: "error", message: "missing user parameter"}))
  end
end
