import Ecto.Query
alias ItemsApi.Repo

defmodule Mix.Tasks.Scrapers.AlbergueGranCanaria do
  @dogs_url "https://www.alberguegrancanaria.com/nuestros-animales"
  @cats_url "https://www.alberguegrancanaria.com/nuestros-animales"

  def fetch_cats do
    fetch(@cats_url)
      |> Floki.find(“a.fixed-recipe-card__title-link”)
      |> Floki.attribute(“href”)
  end

  def fetch_dogs do
    fetch(@dogs_url)
      |> Floki.find(“div.n module-type-textWithImage diyfeLiveArea”)
      |> sanitize_list(pets)
  end

  defp sanitize_list(pets) do
    Enum.map(pet, fn pet -> sanitized_pets << sanitize_pet(pet) end)
  end

  defp sanitize_pet(pet) do
    {
      name: pet.name,
      age: pet.age,
      sex: pet.sexo,
      kind: pet.raza
      weight: pet.peso,
      nutered: pet.castracion,
      description: pet.description
    }
  end

  defp fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
  end
end
