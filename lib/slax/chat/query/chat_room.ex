defmodule Slax.Chat.Room.Query.ChatRoom do
  @moduledoc false

  import Ecto.Query

  alias Slax.Repo
  alias Slax.Chat.Room

  @spec fetch_one_room :: %Room{} | nil
  def fetch_one_room do
    query = from u in Room, limit: 1
    Repo.one(query)
  end
end
