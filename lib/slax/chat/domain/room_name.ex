defmodule Slax.Chat.Room.Domain.RoomName do
  @moduledoc """
  A helper module for managing chat rooms.

  This module provides functions for generating and managing a chat room.
  """

  @max_allowed_rooms 10_000_000

  def generate_room_name_random() do
    marvel_heroes_names = [
      "Iron man",
      "Spider-man",
      "Hawkeye",
      "Nick Furry",
      "Nebula",
      "Ant-man",
      "Phoenix",
      "Wanda"
    ]

    random_id = Enum.random(0..@max_allowed_rooms)

    if Enum.empty?(marvel_heroes_names) do
      {:error, "No names available for chat room generation"}
    else
      hero_picked = Enum.random(marvel_heroes_names)
      "#{hero_picked} - #{random_id}"
    end
  end
end
