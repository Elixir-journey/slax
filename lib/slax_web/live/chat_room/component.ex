defmodule SlaxWeb.Live.ChatRoom do
  use SlaxWeb, :live_view

  alias SlaxWeb.Live.Entities.ChatRoom

  @max_number_of_rooms 10_000_000

  def render(assigns) do
    room_id = Enum.random(0..@max_number_of_rooms)
    room_name = generate_room_name_random(room_id)

    chat_room = %ChatRoom{room_id: room_id, room_name: room_name}

    ~H"""
      <div>Welcome to the chat!</div>
      <div> <%= "This is the room ID: #{chat_room.room_name}" %> </div>
    """
  end

  defp generate_room_name_random(room_id) do
    # Let's say for now that these are the only allowed names for a chat room.
    marvel_heroes_names = ["Iron man", "Spider-man", "Hawkeye", "Nick Furry", "Nebula", "Ant-man", "Phoenix", "Wanda"]

    hero_picked = Enum.random(marvel_heroes_names)

    "#{hero_picked} - #{room_id}"
  end
end
