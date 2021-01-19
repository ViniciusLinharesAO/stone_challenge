defmodule Mix.Tasks.Run do
  use Mix.Task

  def run(_) do
    # Mix.Task.run("app.start")
    StoneChallenge.main()
  end
end
