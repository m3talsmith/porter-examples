defmodule Porter.ServerActions do

  def handle_incoming(func_str, args) do
    func_name = String.to_existing_atom(func_str)
    apply(__MODULE__, func_name, [args])
  end

  def echo(args), do: Enum.join(args, " ")
  def say_hi(_), do: "<h1> HI... </h1>"

end


