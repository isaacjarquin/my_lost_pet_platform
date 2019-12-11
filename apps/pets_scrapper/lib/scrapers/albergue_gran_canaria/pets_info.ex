defmodule Scrapers.AlbergueGranCanaria.PetsInfo do
  @albergue_gran_canaria_url "https://www.alberguegrancanaria.com"

  def get(slugs_url) do
    Enum.map(slugs_url, fn slug -> request_pet_info(slug) |> extract_info() end)
  end

  defp extract_info(pet) do
    pet |> Floki.find("div.contenido_pagina")
  end

  defp request_pet_info(slug) do
    url = @albergue_gran_canaria_url <> slug

    case HTTPoison.get(url, %{}, hackney: [follow_redirect: true]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
    end
  end
end
