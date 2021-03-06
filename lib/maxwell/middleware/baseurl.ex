defmodule Maxwell.Middleware.BaseUrl do
  @moduledoc  """
  Sets the base url for all requests in this module.

  ## Examples

        # Client.ex
        use Maxwell.Builder ~(get)a
        middleware Maxwell.Middleware.BaseUrl, "http{s}://example.com"

        def get_home_page do
          # request http{s}://example.com"
          Client.get!
        end

        def request(path) do
          # http{s}://example.com/\#\{path\}"
          put_path(path) |> Client.get!
        end

        def request_other() do
          # http{s}://other.com/other_path"
          "http{s}://other.com/other_path" |> new() |> Client.get!
          end

        # Add query to url.
        def request(url, query)when is_map(query) do
          url |> new() |> put_query_string(query) |> Client.get!
        end

  """
  use Maxwell.Middleware

  def request(%Maxwell.Conn{} = conn, base_url) do
    if Regex.match?(~r/^https?:\/\//, conn.url) do
      conn
    else
      %{conn | url: base_url}
    end
  end
end

