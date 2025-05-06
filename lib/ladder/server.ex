defmodule Ladder.Server do
  use GenServer

  alias Ladder.Board

  # Client
  # start_link
  # make_move

  # Server
  def init(args) do
    {:ok, Board.new(args)}
  end

  # handle_call
  def handle_call({:turn, word}, _from, board) do
    new_board = Board.turn(board, word)

    {:reply, Board.show(new_board), new_board}
  end
end
