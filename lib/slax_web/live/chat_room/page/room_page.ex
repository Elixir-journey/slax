defmodule SlaxWeb.Live.ChatRoom.Page do
  use SlaxWeb, :live_view

  alias SlaxWeb.Live.ChatRoom.{Querying.RoomQueries, Helpers.Room}

  # When a LiveView page is opened, the first thing that gets done is mounting the page. It's the LiveView entrypoint.
  # mount/3 is called 2x; once of the page loads and then again to establish the live websocket.
  # The live websocket is used to make a point of contact between the browser and the backend server.
  # If it isn't defined on a page, Phoenix will fall back to a given default behavior.
  # Source: https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#c:mount/3

  def mount(_params, _session, socket) do
    slax_chat_room = RoomQueries.get_first_room()

    socket = assign(socket, slax_room: slax_chat_room)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
   <div class="flex flex-col flex-grow shadow-lg">
     <div class="flex justify-between items-center flex-shrink-0 h-16 bg-white border-b border-slate-300 px-4">
       <div class="flex flex-col gap-1.5">
         <h1 class="text-sm font-bold leading-none">
           #room-name
         </h1>
         <div class="text-xs leading-none h-3.5">Placeholder topic</div>
       </div>
     </div>
   </div>
   """
  end

  # def render(assigns) do
  #   case Room.build_chat_room(@max_number_of_rooms) do
  #     {:ok, chat_room_entity} ->
  #       # Properly assign chat_room_entity to assigns
  #       assigns = assign(assigns, :chat_room_entity, chat_room_entity)

  #       ~H"""
  #       <div id={"room-#{@chat_room_entity.room_id}"}>
  #         <div>
  #           <%= "Welcome to this awesome chat room! This is the room ID: #{@chat_room_entity.room_name}" %>
  #         </div>

  #         <%= if Room.anyone_connected?(@chat_room_entity) do %>
  #           <div>
  #             <%= "You are among #{@chat_room_entity.user_connected_count - 1} users connected" %>
  #           </div>
  #         <% else %>
  #           <div>No one else is connected here except for you 🥲 </div>
  #         <% end %>
  #       </div>
  #       """

  #     {:error, message} ->
  #       # Assign error message to assigns
  #       assigns = assign(assigns, :error_message, message)

  #       ~H"""
  #       <div>Failed to generate chat room: #{@error_message}</div>
  #       """
  #   end
  # end
end
