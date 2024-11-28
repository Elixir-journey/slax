defmodule Slax.Chat.Room.Query.ChatRoom do
  import Ecto.Query

  alias Slax.Repo
  alias Slax.Chat.Room

  @paginated_results_limit 100

  @spec get_first_room() :: any()
  def get_first_room(opts \\ []) do
    Room
    |> apply_limit(opts)
    |> apply_offset(opts)
    |> Repo.one()
  end

  defp apply_limit(query, opts) do
    limit = Keyword.get(opts, :limit, @paginated_results_limit)
    from(r in query, limit: ^limit)
  end

  defp apply_offset(query, opts) do
    offset = Keyword.get(opts, :offset, 0)
    from(r in query, offset: ^offset)
  end
end
