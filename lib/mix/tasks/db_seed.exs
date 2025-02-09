defmodule Mix.Tasks.DbSeed do
  @moduledoc """
  A Mix task to seed the database with random chat rooms if none exist.
  """

  use Mix.Task
  alias Slax.Repo
  alias Slax.Chat.Room
  alias Faker.Lorem

  @room_count 10

  def run(_args) do
    # Ensures the application is started
    Mix.Task.run("app.start")

    if Repo.aggregate(Room, :count, :id) == 0 do
      IO.puts("=== Seeding initial chat rooms ===")

      num_rooms = Enum.random(@room_count)

      for _ <- 1..num_rooms do
        Repo.insert!(%Room{
          name: Lorem.word() |> String.capitalize(),
          topic: Lorem.sentence()
        })
      end

      IO.puts("=== Seeded #{num_rooms} chat rooms ===")
    else
      IO.puts("=== Database already has chat rooms, skipping seeding ===")
    end
  end
end
