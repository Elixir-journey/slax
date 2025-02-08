defmodule SlaxWeb.Live.ChatRoom.Page do
  @moduledoc false

  use SlaxWeb, :live_view

  alias Slax.Chat.Room
  alias Slax.Chat.Room.Query.ChatRoom
  alias SlaxWeb.LiveViewHelpers, as: Helpers

  @default_chat_room %Room{name: "Unknown", topic: "No topic"}

  @spec mount(any(), any(), any()) :: {:ok, any()}
  @doc """
  LiveView entrypoint, called twice: once on initial page load and again on websocket connection.

  - Fetches the first chat room and assigns it to `:slax_room`.
  """
  def mount(_params, _session, socket) do
    socket
    |> assign_chat_room()
    |> Helpers.ok()
  end

  defp assign_chat_room(socket) do
    room = ChatRoom.fetch_one_room()

    if is_nil(room) do
      socket
      |> assign(slax_room: @default_chat_room)
      |> assign(hide_topic?: false)
    else
      socket
      |> assign(slax_room: room)
      |> assign(hide_topic?: false)
    end
  end

  def handle_event("toggle-topic", _params, socket) do
    {:noreply, socket}
    {:noreply, assign(socket, hide_topic?: !socket.assigns.hide_topic?)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col flex-grow shadow-lg">
      <div class="flex justify-between items-center flex-shrink-0 h-16 bg-white border-b border-slate-300 px-4">
        <div class="flex flex-col gap-1.5">
          <h1 class="text-sm font-bold leading-none">
            #room-name {@slax_room.name} yo
          </h1>
          <div
            class={["text-xs leading-none h-3.5", @hide_topic? && "text-slate-600"]}
            phx-click="toggle-topic"
          >
            <%= if @hide_topic? do %>
              [Topic hidden]
            <% else %>
              {@slax_room.topic}
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
