defmodule Scrapers.AlbergueGranCanaria do
  @pets_url "https://www.alberguegrancanaria.com/nuestros-animales"

  def fetch_pets_urls do
    fetch_urls(@pets_url)
      |> Floki.find("div.item-list")
      |> Floki.find("ul")
      |> get_pets()
  end

  def fetch_pets_info(slugs_url) do
    Enum.map(slugs_url, fn slug -> fetch_pets_info(slug) |> extract_pet_info() end)
  end

  defp get_pets(pets) do
    Enum.map(pets, fn pet -> pet |> Floki.attribute("href") end)
  end

  def extract_pet_info(pet) do
    pet
      |> Floki.find("div.contenido_pagina")
      |> Floki.find("div.ficha-dch")
  end

  def fetch_pets_info(slug) do
    url = @pets_url <> slug
    case HTTPoison.get(url, %{}, hackney: [follow_redirect: true]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
    end
  end

  defp fetch_urls(url) do
    case HTTPoison.get(url, %{}, hackney: [follow_redirect: true]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
    end
  end
end
