defmodule Porter.Portal do

  # get this from the config and convert to strings at compile time
  @allowed_modules ["Whatever"] #whitelist e.g. [MyClientLib] 

  def handle_request([module, func | args]) when module in @allowed_modules do
    module_atom = String.to_existing_atom(module)
    func_atom = String.to_existing_atom(func)
    apply(module_atom, func_atom, args)
  end

  def push_to_client(_channel, _response) do
    hello = """
      <div>Hello, Porter<div> 
    """
    WebSockets.broadcast!(:handle, hello)
  end



end