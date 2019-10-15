defmodule Tasks.PetsScraper do

  def update do
    Scrapers.AlbergueGranCanaria.fetch_pets_urls()
      |> Scrapers.AlbergueGranCanaria.fetch_pets()
      |> Builders.AlbergueGranCanaria.build_json()
      |> Handlers.AlbergueGranCanaria.store_pets()
  end
end
