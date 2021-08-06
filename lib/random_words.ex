defmodule RandomWords do
  alias RandomWords.RecurringJob

  def init do
    RecurringJob.start()
  end
end
