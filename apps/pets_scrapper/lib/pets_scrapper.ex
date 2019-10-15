defmodule PetsScrapper do
  @moduledoc """
  Documentation for PetsScrapper.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PetsScrapper.hello()
      :world

  """
  def scrape do
    Scrapers.AlbergueGranCanaria.fetch_pets_urls()
      |> Scrapers.AlbergueGranCanaria.fetch_pets()
      |> Builders.AlbergueGranCanaria.build_json()
      |> Handlers.AlbergueGranCanaria.store_pets()
  end
end
