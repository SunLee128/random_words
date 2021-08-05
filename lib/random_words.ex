defmodule RandomWords do
  @adjective "https://random-word-form.herokuapp.com/random/adjective"
  @noun "https://random-word-form.herokuapp.com/random/noun"

  def start_link, do: GenServer.start_link(__MODULE__, [])

  def combine_words do
    adj = Task.async(fn -> get_words(@adjective) end)
    noun = Task.async(fn -> get_words(@noun) end)

    [returned_adj | _] = Task.await(adj)
    [returned_noun | _] = Task.await(noun)

    "#{returned_adj} #{returned_noun}"
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
