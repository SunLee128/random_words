defmodule RandomWords do
  @adjective "https://random-word-form.herokuapp.com/random/adjective"
  @noun "https://random-word-form.herokuapp.com/random/noun"
  @name :endless_words
  @refetch_interval :timer.seconds(1)
  use GenServer

  def start do
    GenServer.start(__MODULE__, %{}, name: @name)
  end

  def get_words do
    GenServer.call(@name, :get_words)
  end

  def init(_state) do
    initial_state = combine_words()
    refetch()
    {:ok, initial_state}
  end

  def handle_call(:get_words, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:refetch, _state) do
    new_state = combine_words()
    refetch()
    {:reply, new_state}
  end

  defp refetch() do
    Process.send_after(self(), :refetch, @refetch_interval)
  end

  def combine_words do
    adj = Task.async(fn -> get_words(@adjective) end)
    noun = Task.async(fn -> get_words(@noun) end)
    [returned_adj | _] = Task.await(adj)
    [returned_noun | _] = Task.await(noun)
    %{phrase: "#{returned_adj} #{returned_noun}"}
  end

  def get_words(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> Jason.decode!()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        "Not found" |> Jason.decode!()

      {:error, %HTTPoison.Error{reason: reason}} ->
        reason |> Jason.decode!()
    end
  end
end
