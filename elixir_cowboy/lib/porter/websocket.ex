defmodule Porter.WebsocketHandler do
  @behaviour :cowboy_websocket_handler

  def init({tcp, http}, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def websocket_init(_TransportName, req, _opts) do
    IO.puts "New Connection. PID is #{inspect(self())}"

    {:ok, req, :undefined_state }
  end

  def websocket_terminate(_reason, _req, _state) do
    :ok
  end

  def websocket_handle({:text, encoded}, req, state) do
    content = Poison.decode!(encoded)
    IO.puts "websocket handled text: #{inspect content}"
    args = Porter.ServerActions.handle_incoming(content["serverAction"], content["args"])
    response = %{clientAction: content["clientAction"], args: args} |> Poison.encode!
    {:reply, {:text, response}, req, state}
  end

  def websocket_handle(data, req, state) do
    IO.puts     "----------> Caught by fallback"
    IO.inspect  data
    {:ok, req, state}
  end

  def websocket_info({_timeout, _ref, _foo}, req, state) do
    { :reply, {:text, "info"}, req, state}
  end

  # fallback message handler 
  def websocket_info(_info, req, state) do
    IO.puts "called fallback"
    {:ok, req, state}
  end

end

