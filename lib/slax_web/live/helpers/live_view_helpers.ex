defmodule SlaxWeb.LiveViewHelpers do
  @moduledoc """
  Provides reusable helper functions for LiveView modules.
  """

  import Phoenix.Component, only: [assign: 3]
  import Phoenix.LiveView, only: [connected?: 1]

  @doc """
  Returns an `{:ok, socket}` tuple for easier use in pipelines.

  ## Examples

      iex> SlaxWeb.LiveViewHelpers.ok(socket)
      {:ok, socket}

  """
  def ok(socket), do: {:ok, socket}

  @doc """
  Runs the given function if the LiveView socket is connected. Otherwise, returns the socket unchanged.

  ## Examples

      iex> socket = assign(socket, :connected_once, false)
      iex> SlaxWeb.LiveViewHelpers.run_on_connect(socket, fn socket ->
      ...>   assign(socket, :some_key, "value")
      ...> end)
      %{assigns: %{some_key: "value", connected_once: true}}

      iex> socket = %{assigns: %{connected_once: true}}
      iex> SlaxWeb.LiveViewHelpers.run_on_connect(socket, fn socket ->
      ...>   assign(socket, :some_key, "value")
      ...> end)
      %{assigns: %{connected_once: true}}

  """
  def run_on_connect(socket, action_fn) when is_function(action_fn, 1) do
    if connected?(socket) and not Map.get(socket.assigns, :connected_once, false) do
      socket
      |> action_fn.()
      |> assign(:connected_once, true)
    else
      socket
    end
  end

  @doc """
  A convenience function to conditionally run a pipeline based on the connection state.

  ## Examples

      iex> socket = %{assigns: %{my_key: "initial"}}
      iex> SlaxWeb.LiveViewHelpers.halt_if_connected(socket, fn socket ->
      ...>   assign(socket, :my_key, "updated")
      ...> end)
      {:halt, %{assigns: %{my_key: "initial"}}}

      iex> socket = %{assigns: %{my_key: "initial"}}
      iex> SlaxWeb.LiveViewHelpers.halt_if_connected(socket, fn socket ->
      ...>   assign(socket, :my_key, "updated")
      ...> end)
      %{assigns: %{my_key: "updated"}}

  """
  def halt_if_connected(socket, action_fn) when is_function(action_fn, 1) do
    if connected?(socket) do
      {:halt, socket}
    else
      action_fn.(socket)
    end
  end

  @doc """
  Assigns a value to the socket only if it is not already assigned.

  ## Examples

      iex> socket = %{assigns: %{}}
      iex> SlaxWeb.LiveViewHelpers.assign_unless(socket, :key, "value")
      %{assigns: %{key: "value"}}

      iex> socket = %{assigns: %{key: "existing"}}
      iex> SlaxWeb.LiveViewHelpers.assign_unless(socket, :key, "value")
      %{assigns: %{key: "existing"}}

  """
  def assign_unless(socket, key, value) do
    if Map.has_key?(socket.assigns, key) do
      socket
    else
      assign(socket, key, value)
    end
  end
end
