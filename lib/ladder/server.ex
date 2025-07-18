defmodule Ladder.Server do
  use GenServer

  alias Ladder.{Board, Words, Errors}

  # Client
  def start_link({name, difficulty}) do
    IO.puts("Starting for #{name}")
    GenServer.start_link(__MODULE__, Words.initial_random_words(difficulty), name: name)
  end

  def turn(pid, word) do
    {status, reply} = GenServer.call(pid, {:turn, word})

    IO.puts(reply)

    status
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
    make_validated_move(board, word)
  end

  def make_validated_move(board, word) do
    case Errors.validate(word, hd(board.moves)) do
      {:ok, word} ->
        board
        |> Board.turn(word)
        |> reply_or_finish()

      {:error, error} ->
        {:reply, {:ok, Enum.join([Board.show(board) | error], "\n")}, board}
    end
  end

  def reply_or_finish(board) do
    reply = Board.show(board)

    if Board.won?(board) do
      {:stop, :normal, {:done, reply}, board}
    else
      {:reply, {:ok, reply}, board}
    end
  end
end
