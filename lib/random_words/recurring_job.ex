defmodule RandomWords.RecurringJob do

  use Application
  use GenServer

  @api Application.get_env(:random_words, :random_words_api)
  @refetch_interval :timer.seconds(1)
  @server_name :endless_words


  def start do
    GenServer.start(__MODULE__, [], name: @server_name)
  end

  def get_phrase do
    GenServer.call(@server_name, :get_phrase)
  end

  def recent_phrases do
    GenServer.call(@server_name, :recent_phrases)
  end

  def clear do
    GenServer.cast(@server_name, :clear)
  end

  def init(_state) do
    initial_state = @api.phrase()
    refetch()
    {:ok, initial_state}
  end

  def handle_call(:get_phrase, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:clear, _state) do
    []
  end

  def handle_call(:recent_phrases, state) do
    {state, state}
  end

  def handle_info(:refetch, state) do
    new_phrase = @api.phrase()
    most_recent_phrase = Enum.take(state, 3)
    new_state = [new_phrase | most_recent_phrase]
    # refetch()
    {:noreply, new_state}
  end

  defp refetch() do
    Process.send_after(self(), :refetch, @refetch_interval)
  end
end
