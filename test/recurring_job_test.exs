defmodule RecurringJobTest do
  use ExUnit.Case, async: true
  alias RandomWords.RecurringJob

  setup do
    {:ok, pid} = RandomWords.init()
    {:ok, server: pid}
  end

  describe "get_words/1" do
    test "returns a phrase", %{server: pid} do
      assert %{phrase: "secretive equinox"} = RecurringJob.get_words()
    end
  end
end
