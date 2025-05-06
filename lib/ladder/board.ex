defmodule Ladder.Board do
  defstruct [:answer, :moves]

  def new({initial_word, answer}) do
    %__MODULE__{answer: answer, moves: [initial_word]}
  end

  def turn(board, word) do
    %{board | moves: [word | board.moves]}
  end

  def show(board) do
    moves =
      board.moves
      |> Enum.reverse()
      |> Enum.join(" |> ")

    moves <> "|> ... #{board.answer}"
  end
end
