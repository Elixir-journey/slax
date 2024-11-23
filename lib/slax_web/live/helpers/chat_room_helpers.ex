defmodule SlaxWeb.Live.Helpers.ChatRoom do
  alias SlaxWeb.Live.Entities.ChatRoom

  @moduledoc """
  A helper module for managing chat rooms.

  This module provides functions for generating and managing a chat room.
  """

  @doc """
  Builds a new chat room.

  The function generates a random room ID between 0 and the given `max_rooms_supported` value.
  It then generates a random room name by picking a superhero from a predefined list of names
  and appending the room ID to it.

  The function returns a `%ChatRoom{}` struct containing the `room_id` and `room_name`.

  ## Parameters

    - `max_rooms_supported`: A positive number representing the maximum number of chat rooms
      supported. It can be an integer or a float. The function will generate a random room ID
      between 0 and this value.

  ## Returns

    - `{:ok, %ChatRoom{}}`: A tuple containing the successfully created chat room struct.
    - `{:error, reason}`: A tuple with an error message if the `max_rooms_supported` is invalid
      (not a positive number).

  ## Examples

      iex> SlaxWeb.Live.Helpers.ChatRoom.build_chat_room(1000)
      {:ok, %ChatRoom{room_id: 4523, room_name: "Iron man - 4523"}}

      iex> SlaxWeb.Live.Helpers.ChatRoom.build_chat_room(-1)
      {:error, "Invalid input: max_rooms_supported must be a positive number"}

  """
  def build_chat_room(max_rooms_supported) when is_number(max_rooms_supported) and max_rooms_supported > 0 do
    room_id = Enum.random(0..max_rooms_supported)
    room_name = generate_room_name_random(room_id)

    {:ok, %ChatRoom{room_id: room_id, room_name: room_name}}
  end

  # Error handling for invalid inputs (non-numbers or non-positive numbers)
  def build_chat_room(_) do
    {:error, "Invalid input: max_rooms_supported must be a positive number"}
  end

  defp generate_room_name_random(room_id) do
    marvel_heroes_names = ["Iron man", "Spider-man", "Hawkeye", "Nick Furry", "Nebula", "Ant-man", "Phoenix", "Wanda"]

    # Ensure the list is not empty before attempting random selection
    if length(marvel_heroes_names) == 0 do
      {:error, "No names available for chat room generation"}
    else
      hero_picked = Enum.random(marvel_heroes_names)
      "#{hero_picked} - #{room_id}"
    end
  end
end
