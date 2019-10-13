defmodule Mix.Tasks.PetsScraper do
  alias ItemsApi.Item

  def update do
    handle_pets_from_ceta_ingenio
    # handle_pets_from_albergue_gran_canaria
  end

  defp handle_pets_from_ceta_ingenio do
    Item.remove_pets_from_ceta_ingenio

    handle_cats_from_ceta_ingenio
    handle_dogs_from_ceta_ingenio
  end

  defp handle_pets_from_albergue_gran_canaria do
    Item.remove_pets_from_albergue_gran_canaria

    handle_cats_from_albergue_gran_canaria
    handle_dogs_from_albergue_gran_canaria
  end

  defp handle_cats_from_ceta_ingenio do
    Scrapers.CetaIngenio.fetch_cats()
      |> Mix.Pets.CetaIngenio.store_cats()
  end

  defp handle_dogs_from_ceta_ingenio do
    Scrapers.CetaIngenio.fetch_dogs()
      |> Mix.Pets.CetaIngenio.store_dogs()
  end

  defp handle_cats_from_albergue_gran_canaria do
    Scrapers.AlbergueGranCanaria.fetch_cats()
      |> Mix.Pets.AlbergueGranCanaria.store_cats()
  end

  defp handle_dogs_from_albergue_gran_canaria do
    Scrapers.AlbergueGranCanaria.fetch_cats()
      |> Mix.Pets.AlbergueGranCanaria.store_dogs()
  end
end
