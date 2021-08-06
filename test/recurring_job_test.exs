defmodule RecurringJobTest do
  use ExUnit.Case, async: true

  @adjective "https://random-word-form.herokuapp.com/random/adjective"
  @noun "https://random-word-form.herokuapp.com/random/noun"
  @server_name :endless_words
  @refetch_interval :timer.seconds(1)

  setup do
    {:ok, pid} = RandomWords.start()
    {:ok, server: pid}
  end

  describe "get_words/1" do
    test "returns a phrase", %{server: pid} do
      response = RandomWords.get_words()

      IO.inspect(response)
    end
  end
end
