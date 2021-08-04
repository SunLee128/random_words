defmodule RandomWords do
  @noun "https://random-word-form.herokuapp.com/random/noun"
  @adjective "https://random-word-form.herokuapp.com/random/adjective"

  def get_nouns do
    case HTTPoison.get(@adjective) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
