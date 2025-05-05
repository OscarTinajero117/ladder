defmodule Ladder.Board do
  @words Ladder.Dictionary.words()
  @word_index Ladder.Dictionary.index_words(@words)

  def new({initial_word, answer}) do
    # %__MODULE__{}
  end

  def guess(board, word) do
    # ...word...
  end

  def show(board) do
    # "cats > mats ... ?"
  end
end
