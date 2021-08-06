defmodule RandomWords.Words do
  @adjective_url "https://random-word-form.herokuapp.com/random/adjective"
  @noun_url "https://random-word-form.herokuapp.com/random/noun"

  def phrase do
    adj = Task.async(fn -> get(@adjective_url) end)
    noun = Task.async(fn -> get(@noun_url) end)
    [returned_adj | _] = Task.await(adj)
    [returned_noun | _] = Task.await(noun)
    %{phrase: "#{returned_adj} #{returned_noun}"}
  end

  def get(url) do
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
