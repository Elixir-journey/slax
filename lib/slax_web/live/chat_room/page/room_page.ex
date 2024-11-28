defmodule SlaxWeb.Live.ChatRoom.Page do
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
  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket
    |> assign(is_topic_hidden: false)
    |> assign_chat_room()
    |> Helpers.ok()
  end

  @impl Phoenix.LiveView
  def handle_event("toggle-topic", _params, socket) do
    {:noreply,
      socket |> assign(is_topic_hidden: !socket.assigns.is_topic_hidden)}
  end

  defp assign_chat_room(socket) do
    with room when not is_nil(room) <- ChatRoom.get_first_room() do
      assign(socket, :slax_room, room)
    else
      _ -> assign(socket, :slax_room, @default_chat_room)
    end
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="flex flex-col flex-grow shadow-lg">
      <div class="flex justify-between items-center flex-shrink-0 h-16 bg-white border-b border-slate-300 px-4">
        <div class="flex flex-col gap-1.5">
          <h1 class="text-sm font-bold leading-none">
            #room-name
            <%= @slax_room.name %>
          </h1>
          <div class="text-xs leading-none h-3.5" phx-click="toggle-topic">
            <%= if @is_topic_hidden do %>
              <span class="text-slate-600">[Topic hidden]</span>
            <% else %>
              <%= @slax_room.topic %>
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
