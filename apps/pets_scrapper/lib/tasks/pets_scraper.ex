defmodule Tasks.PetsScraper do

  def update do
    Scrapers.AlbergueGranCanaria.fetch_pets_urls()
      |> Scrapers.AlbergueGranCanaria.fetch_pets()
      |> Formatters.AlbergueGranCanaria.format_pets()
      |> Handlers.AlbergueGranCanaria.store_pets()
  end
end
