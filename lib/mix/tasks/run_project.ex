defmodule Mix.Tasks.RunProject do
  use Mix.Task

  def run(_) do
    # Mix.Task.run("app.start")
    StoneChallenge.main() |> IO.inspect()
  end
end
