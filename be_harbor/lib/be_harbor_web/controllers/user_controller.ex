defmodule BeHarborWeb.UserController do
  use BeHarborWeb, :controller

  def me(conn, _params) do
    {_conn, user} = BeHarborWeb.APIAuthPlug.fetch(conn, [])
    user.email |> IO.inspect()
    resp(conn, 200, "{\"username\": \"WIP\", \"email\":\"#{user.email}\"}")
  end
end
