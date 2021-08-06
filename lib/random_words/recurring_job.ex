defmodule RandomWords.RecurringJob do
  use Application
  @api Application.get_env(:random_words, :random_words_api)

  @refetch_interval :timer.seconds(1)

  use GenServer

  @server_name :endless_words
  def start do
    GenServer.start(__MODULE__, %{}, name: @server_name)
  end

  def get_words do
    GenServer.call(@server_name, :get_words)
  end

  def init(_state) do
    initial_state = @api.phrase()
    # refetch()
    {:ok, initial_state}
  end

  def handle_call(:get_words, _from, state) do
    {:reply, state, state}
  end

  # def handle_info(:refetch, _state) do
  #   new_state = api.phrase()
  #   # refetch()
  #   {:reply, new_state}
  # end

  # defp refetch() do
  #   Process.send_after(self(), :refetch, @refetch_interval)
  # end
end
