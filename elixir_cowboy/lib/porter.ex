defmodule Porter do

  def start(_type, _args) do
    dispatch = :cowboy_router.compile([{ :_, routes }])
    IO.puts "Starting Porter on localhost:8080 ..."
    { :ok, _ } = :cowboy.start_http(:http, 
                                    100,
                                   [{:port, 8080}],  
                                   [{ :env, [{:dispatch, dispatch}]}]
                                   )
  end

  def routes do
    [
      {"/",             :cowboy_static,     {:priv_file, :porter, "index.html"}},
      {"/static/[...]", :cowboy_static,     {:priv_dir,  :porter, "static"}},
      {"/websocket", Porter.WebsocketHandler, []}
    ]

  end
end
