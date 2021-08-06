defmodule WordsTest do
  use ExUnit.Case, async: true
  alias RandomWords.Words

@api Application.get_env(:random_words, :random_words_api)
  describe "phrase" do
    test "returns a phrase value." do
      @api.phrase() |> IO.inspect()
    end
  end
end
