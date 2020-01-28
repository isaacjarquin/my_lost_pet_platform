defmodule Scrapers.AlbergueGranCanaria do
  @pets_url "https://www.alberguegrancanaria.com/nuestros-animales"

  def get_pets do
    Scrapers.AlbergueGranCanaria.PetsUrls.get()
      |> Scrapers.AlbergueGranCanaria.PetsInfo.get()
  end
end
