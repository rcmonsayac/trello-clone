defmodule TrelloCloneApiWeb.Resources.BoardResources do

  alias TrelloCloneApi.Boards
  alias TrelloCloneApi.Boards.BoardPermission


  def resource(conn, {:board, :board_permission}, %{"id" => board_id}) do
    user_id = conn.assigns.current_user.id
    with %BoardPermission{} = permission <- Boards.get_board_permission!(board_id, user_id) do
      {:ok, :board_permission, permission}
    else
      _ ->
        {:error, :board_permission}
    end
  end

  def resource(conn, {:list, :board_permission}, %{"board_id" => board_id}) do
    user_id = conn.assigns.current_user.id
    IO.inspect(board_id)
    with %BoardPermission{} = permission <- Boards.get_board_permission!(board_id, user_id) do
      IO.inspect(permission)
      {:ok, :board_permission, permission}
    else
      _ ->
        {:error, :board_permission}
    end
  end

end
