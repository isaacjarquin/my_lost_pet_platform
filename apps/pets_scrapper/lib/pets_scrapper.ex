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
    Scrapers.AlbergueGranCanaria.get_pets()
      |> Builders.AlbergueGranCanaria.build_json()
      # |> Services.PetsApi.send_pets()
  end
end
