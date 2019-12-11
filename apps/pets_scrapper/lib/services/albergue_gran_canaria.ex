defmodule Services.PetsApi do
  @post_url = ""

  def send_pets(pets) do
    pets |> post
  end

  defp post(pets) do
    header = %{"Content-Type" => "application/json"}

    case HTTPoison.post(@post_url, pets, header) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
  end
end
