defmodule RecurringWords do
  use Application

  import Supervisor.Spec

  def start(_type, _args) do
    Supervisor.start_link([worker(RandomWords, [])],
      strategy: :one_for_one,
      name: RecurringWords.Supervisor
    )
  end
end
