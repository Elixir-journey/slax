defmodule SlaxWeb.Live.ChatRoom.Page do
  use SlaxWeb, :live_view

  alias SlaxWeb.Live.ChatRoom.Helpers.Room

  @max_number_of_rooms 10_000_000

  def render(assigns) do
    case Room.build_chat_room(@max_number_of_rooms) do
      {:ok, chat_room_entity} ->
        # Properly assign chat_room_entity to assigns
        assigns = assign(assigns, :chat_room_entity, chat_room_entity)

        ~H"""
        <div id={"room-#{@chat_room_entity.room_id}"}>
          <div>
            <%= "Welcome to this awesome chat room! This is the room ID: #{@chat_room_entity.room_name}" %>
          </div>

          <%= if Room.anyone_connected?(@chat_room_entity) do %>
            <div>
              <%= "You are among #{@chat_room_entity.user_connected_count - 1} users connected" %>
            </div>
          <% else %>
            <div>No one else is connected here except for you 🥲</div>
          <% end %>
        </div>
        """

      {:error, message} ->
        # Assign error message to assigns
        assigns = assign(assigns, :error_message, message)

        ~H"""
        <div>Failed to generate chat room: #{@error_message}</div>
        """
    end
  end
end
