defmodule SlaxWeb.Live.ChatRoom.Page do
  @moduledoc false

  use SlaxWeb, :live_view

  alias Slax.Chat.Room
  alias Slax.Repo

  @spec mount(any(), any(), any()) :: {:ok, any()}
  @doc """
  LiveView entrypoint, called twice: once on initial page load and again on websocket connection.
  - Fetches the first chat room and assigns it to `:slax_room`.
  """
  def mount(params, _session, socket) do
    socket
    |> assign_chat_room(params)
    |> SlaxWeb.LiveViewHelpers.ok()
  end

  defp assign_chat_room(socket, params) do
    rooms = Repo.all(Room)

    room =
      case Map.fetch(params, "id") do
        {:ok, id} ->
          %Room{} = Enum.find(rooms, &(to_string(&1.id) == id))

        :error ->
          List.first(rooms)
      end

    socket
    |> assign(room: room)
    |> assign(rooms: rooms)
    |> assign(hide_topic?: false)
  end

  def handle_event("toggle-topic", _params, socket) do
    {:noreply, update(socket, :hide_topic?, &(!&1))}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col flex-shrink-0 w-64 bg-slate-100">
      <div class="flex justify-between items-center flex-shrink-0 h-16 border-b border-slate-300 px-4">
        <div class="flex flex-col gap-1.5">
          <h1 class="text-lg font-bold text-gray-800">
            Slax
          </h1>
        </div>
      </div>
      <div class="mt-4 overflow-auto">
        <div class="flex items-center h-8 px-3">
          <span class="ml-2 leading-none font-medium text-sm">Rooms</span>
        </div>
        <div id="rooms-list">
          <.room_link :for={room <- @rooms} room={room} active={room.id == @room.id} />
        </div>
      </div>
    </div>
    <div class="flex flex-col flex-grow shadow-lg">
      <div class="flex justify-between items-center flex-shrink-0 h-16 bg-white border-b border-slate-300 px-4">
        <div class="flex flex-col gap-1.5">
          <h1 class="text-sm font-bold leading-none">
            #{@room.name}
          </h1>
          <div class="text-xs leading-none h-3.5" phx-click="toggle-topic">
            <%= if @hide_topic? do %>
              <span class="text-slate-600">[Topic hidden]</span>
            <% else %>
              {@room.topic}
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  attr :active, :boolean, required: true
  attr :room, Room, required: true

  defp room_link(assigns) do
    ~H"""
    <a
      class={[
        "flex items-center h-8 text-sm pl-8 pr-3",
        (@active && "bg-slate-300") || "hover:bg-slate-300"
      ]}
      href={~p"/rooms/#{@room}"}
    >
      <.icon name="hero-hashtag" class="h-4 w-4" />
      <span class={["ml-2 leading-none", @active && "font-bold"]}>
        {@room.name}
      </span>
    </a>
    """
  end
end
