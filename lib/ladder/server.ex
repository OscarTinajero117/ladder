defmodule Ladder.Server do
  use GenServer

  alias Ladder.{Board, Words}

  # Client
  def start_link({name, difficulty}) do
    IO.puts("Starting for #{name}")
    GenServer.start_link(__MODULE__, Words.initial_random_words(difficulty), name: name)
  end

  def turn(pid, word) do
    GenServer.call(pid, {:turn, word})
  end

  # Server
  def init(args) do
    board = Board.new(args)

    board
    |> Board.show()
    |> IO.puts()

    {:ok, board}
  end

  # handle_call
  def handle_call({:turn, word}, _from, board) do
    new_board = Board.turn(board, word)

    {:reply, Board.show(new_board), new_board}
  end
end
