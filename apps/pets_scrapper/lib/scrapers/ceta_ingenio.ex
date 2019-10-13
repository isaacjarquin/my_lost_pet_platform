import Ecto.Query
alias ItemsApi.Repo

defmodule Mix.Tasks.Scrapers.CetaIngenio do
  @dogs_url "https://www.cetacesingenio.com/perros/"
  @cats_url "https://www.cetacesingenio.com/gatos/"

  def fetch_cats do
    fetch(@cats_url)
    |> Floki.find(“div.n module-type-textWithImage diyfeLiveArea”)
    |> Floki.find(“div.n module-type-textWithImage diyfeLiveArea”)
    |> Floki.attribute(“href”)
  end

  def fetch_dogs do
    fetch(@dogs_url)
      |> Floki.find(“div.n module-type-textWithImage diyfeLiveArea”)
      |> Floki.find(“textwrapper”)
      |> sanitize_list(pets)
  end

  defp sanitize_list(pets) do
    Enum.map(pets, fn pet -> sanitized_pets << sanitize_pet(pet) end)
  end

  defp sanitize_pet(pet_fields) do
    Enum.map(pet_fields, fn field -> fields << {Floki.find(“p.span”)})
     |> sanitize_array_of_fields
  end

  def sanitize_array_of_fields(fields) do
    {
      name: fields[0],
      age: fields[1],
      sex: fields[2],
      kind: fields[3],
      weight: fields[4],
      nutered: fields[5],
      description: fields[6]
    }
  end

  defp fetch(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
  end
end