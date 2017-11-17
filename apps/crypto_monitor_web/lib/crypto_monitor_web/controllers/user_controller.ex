defmodule CryptoMonitor.Web.UserController do
  use CryptoMonitor.Web, :controller

  alias Crypto.User

  action_fallback CryptoMonitor.Web.ErrorFallBackUserController

  def signup(conn, params) do
    changeset = User.signup_changeset(%User{}, params["user"])
    if changeset.valid? do
      user_name = params["user"]["name"]
      pin = params["user"]["name"]
      User.create(changeset)
      conn
        |> put_session(:user, user_name)
        |> put_session(:token, pin)
        |> redirect(to: "/balance")
    else
      changeset.errors
    end
  end

  def logout(conn, _params) do
    conn
      |> clear_session
      |> redirect(to: "/bussines")
  end

  def login(conn, params) do
    changeset = User.login_changeset(%User{}, params["user"])
    if changeset.valid? do
      user_name = params["user"]["name"]
      pin = params["user"]["name"]
      conn
        |> put_session(:user, user_name)
        |> put_session(:token, pin)
        |> redirect(to: "/balance")
    else
      changeset.errors
    end
  end
end
