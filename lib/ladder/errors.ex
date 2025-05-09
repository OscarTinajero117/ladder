defmodule Ladder.Errors do
  @moduledoc """
  This module defines custom error types for the Ladder game.
  """

  alias Ladder.Words

  defp list(word, previous) do
    []
    |> maybe_add_error(Words.member?(word), "The word (#{word}) not in dictionary.")
    |> maybe_add_error(Words.correct_length?(word), "The word (#{word}) must be 4 letters long.")
    |> maybe_add_error(
      Words.exactly_one_change?(word, previous),
      "The word (#{word}) to previous (#{previous}) does not have exactly one change."
    )
  end

  def validate(word, previous) do
    case list(word, previous) do
      [] ->
        {:ok, word}

      errors ->
        {:error, errors}
    end
  end

  defp maybe_add_error(list, false, error), do: [error | list]
  defp maybe_add_error(list, true, _error), do: list
end
