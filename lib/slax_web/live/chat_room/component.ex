defmodule SlaxWeb.Live.ChatRoom do
  use SlaxWeb, :live_view

  alias SlaxWeb.Live.Helpers.ChatRoom

  @max_number_of_rooms 10_000_000

  def render(assigns) do
    case ChatRoom.build_chat_room(@max_number_of_rooms) do
      {:ok, chat_room_entity} ->
        assigns = assign(assigns, :chat_room_entity, chat_room_entity)
        ~H"""
        <div>Welcome to the chat!</div>
        <div> <%= "This is the room ID: #{@chat_room_entity.room_name}" %> </div>
        """

      {:error, message} ->
        assigns = assign(assigns, :error_message, message)
        ~H"""
        <div>Failed to generate chat room: #{@error_message}</div>
        """
    end
  end
end
