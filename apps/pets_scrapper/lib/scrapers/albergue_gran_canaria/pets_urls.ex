defmodule Scrapers.AlbergueGranCanaria.PetsUrls do
  @pets_url "https://www.alberguegrancanaria.com/nuestros-animales"

  def get do
    request_pets_urls(@pets_url)
      |> Floki.find("div.item-list")
      |> Floki.find("ul")
      |> Floki.find("a")
      |> Floki.attribute("href")
  end

  defp request_pets_urls(url) do
    case HTTPoison.get(url, %{}, hackney: [follow_redirect: true]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
    end
  end
end
