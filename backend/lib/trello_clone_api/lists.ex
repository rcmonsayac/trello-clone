defmodule TrelloCloneApi.Lists do
  alias Ecto.Changeset
  import Ecto.Query, warn: false
  alias TrelloCloneApi.Repo

  alias TrelloCloneApi.Lists.List


  def all_list do
    Repo.all(List)
  end


  def all_board_lists(board_id) do
    query =
      from l in List,
        where: l.board_id == ^board_id
    Repo.all(query)
  end


  def get_list!(id), do: Repo.get!(List, id)

  def create_list(attrs \\ %{}) do
    case Map.pop(attrs, "board_id")  do
      {board_id, _} when not is_nil(board_id) ->
        position = get_last_position(board_id)
        %List{}
        |> List.changeset(Map.merge(attrs, %{"position" => position}))
        |> Repo.insert()

      _ ->
        %List{}
        |> List.changeset(attrs)
        |> Changeset.apply_changes
    end
  end

  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  def delete_list(%List{} = list) do
    Repo.delete(list)
  end

  def change_list(%List{} = list, attrs \\ %{}) do
    List.changeset(list, attrs)
  end

  def get_last_position(board_id) do
    query =
      from l in List,
        where: l.board_id == ^board_id,
        select: max(l.position)

    Repo.one(query)
    |> Kernel.||(0)
    |> Decimal.add(1)
  end

end
