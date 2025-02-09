# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Slax.Repo.insert!(%Slax.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Slax.Repo
alias Slax.Chat.Room
alias Faker.Lorem

# Ensure the app and its dependencies are started.
{:ok, _} = Application.ensure_all_started(:slax)

defmodule DatabaseSeeder do
  def seed_chat_rooms(room_count) do
    IO.puts("=== Seeding initial chat rooms ===")

    for _ <- 1..room_count do
      Repo.insert!(%Room{
        name: Lorem.word() |> String.capitalize(),
        topic: Lorem.sentence()
      })
    end

    IO.puts("=== Seeded #{room_count} chat rooms ===")
  end
end

IO.puts("Seeding database...")

DatabaseSeeder.seed_chat_rooms(10)
