defmodule TrelloCloneClientWeb.RegistrationController do
  use TrelloCloneClientWeb, :controller

  alias TrelloCloneClient.Schemas.User
  alias TrelloCloneClient.Auth
  alias TrelloCloneClient.API.Users

  def index(conn, _params) do
    conn
    |> assign(:access_token, nil)
    |> assign(:current_user, nil)
    |> assign(:changeset, User.registration_changeset(%User{}))
    |> render("register.html")
  end

  def register(conn, %{"user" => user_params} = _params) do

    with {:ok, user} <- Users.validate(user_params),
         {:ok, body} <- Auth.register(user) do
      redirect(conn, to: Routes.session_path(conn, :create, body))
    else
      {:error,  %Ecto.Changeset{} = changeset  } ->
        conn
        |> assign(:access_token, nil)
        |> assign(:current_user, nil)
        |> assign(:changeset, %{changeset | action: :signin})
        |> render("register.html")
      _error ->
        conn
        |> assign(:access_token, nil)
        |> assign(:current_user, nil)
        |> put_flash(:error, "Email already taken.") #expand more on error handling
        |> assign(:changeset, User.registration_changeset(%User{}, user_params))
        |> render("register.html")
    end
  end

end
