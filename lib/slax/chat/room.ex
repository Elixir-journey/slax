defmodule Slax.Chat.Room do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  # By default, a schema will automatically generate a primary key which is named id and of type :integer.
  # The field macro defines a field in the schema with given name and type.
  # Source: https://hexdocs.pm/ecto/Ecto.Schema.html
  schema "rooms" do
    # Albeit DB systems might make a distinction for varchar/text/etc, the atom :string is the type that Elixir will use to
    # manipulate the value associated with the column :field_name (e.g., :name). It's not referring to the Postgres value here.
    # Once we have a recorded loaded from the database, it becomes a full-fledged string in the eyes of the Elixir type system.

    field :name, :string
    field :topic, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :topic])
    |> validate_required([:name, :topic])
  end
end
