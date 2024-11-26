defmodule SlaxWeb.Live.ChatRoom.Helpers.Room do
  alias Slax.Repo
  alias Slax.Chat.Room

  @initial_users_in_room 0
  @max_allowed_rooms 10_000_000

  @moduledoc """
  A helper module for managing chat rooms.

  This module provides functions for generating and managing a chat room.
  """

  def generate_room_name_random() do
    marvel_heroes_names = ["Iron man", "Spider-man", "Hawkeye", "Nick Furry", "Nebula", "Ant-man", "Phoenix", "Wanda"]
    random_id = Enum.random(0..@max_allowed_rooms)

    if length(marvel_heroes_names) == 0 do
      {:error, "No names available for chat room generation"}
    else
      hero_picked = Enum.random(marvel_heroes_names)
      "#{hero_picked} - #{random_id}"
    end
  end
end
