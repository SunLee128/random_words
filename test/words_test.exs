defmodule WordsTest do
  use ExUnit.Case, async: true

  @api Application.get_env(:random_words, :random_words_api)
  describe "phrase" do
    test "returns a phrase value." do
      assert %{phrase: "secretive equinox"} == @api.phrase()
    end
  end
end
