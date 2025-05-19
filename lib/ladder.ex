defmodule Ladder do
  alias Ladder.Server

  @me __MODULE__

  def play(difficulty \\ 2) do
    Server.start_link({@me, difficulty})

    next_turn(:ok)
  end

  def next_turn(:done), do: :complete

  def next_turn(:ok) do
    word =
      IO.gets("Enter a word: ")
      |> String.trim()

    Server.turn(@me, word)
    |> next_turn()
  end
end
