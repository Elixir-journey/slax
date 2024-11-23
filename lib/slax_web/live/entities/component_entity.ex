defmodule SlaxWeb.Live.Entities.ChatRoom do
  @enforce_keys [:room_id, :room_name]
  defstruct [:room_id, :room_name, :user_connected_count]
end
