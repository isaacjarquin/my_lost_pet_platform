defmodule Builders.AlbergueGranCanaria do
  def build_json(pets) do
    Enum.map(pet, fn pet -> build_pet_info_json(pet) end)
  end


  defp build_pet_info_json(pet) do
    {
      name: extract_name(pet),
      pet_code: extrac_code(pet),
      kind: extract_pet_type(pet),
      breed: extract_breed(pet),
      age: extract_age(pet),
      sex: extract_sex(pet),
      size: extrac_size(pet),
      color: extrac_color(pet),
      character: extrac_character(pet)
      checksum: build_checksum(pet)
    }
  end

  defp extract_name(pet) do
    pet
      |> Floki.find("h2")
      |> Floki.find("span")
  end

  defp extrac_code(pet) do
    pet
      |> Floki.find("div.codigo_ficha")
      |> Floki.find("div")
  end

  def extract_breed do
    pet
      |> Floki.find("div.item_ficha")[0]
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("div")
  end

  def extract_age do
    pet
      |> Floki.find("div.item_ficha")[1]
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("div")
  end

  def extract_sex do
    pet
      |> Floki.find("div.item_ficha")[2]
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("div")
  end

  def extrac_size do
    pet
      |> Floki.find("div.item_ficha")[3]
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("div")
  end

  def extrac_color do
    pet
      |> Floki.find("div.item_ficha")[5]
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("div")
  end

  def extrac_character do
    pet
      |> Floki.find("div.item_ficha")[6]
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("div")
  end

  def extract_pet_type do
    pet
      |> Floki.find("div.item_ficha")[0]
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("strong")
      |> pet_type_mapper()
  end

  defp pet_type_mapper(pet_type) do
    if (String.downcase(pet_type) =~ "canina"), do: "perro", else: "gato"
  end


  defp build_checksum(pet) do
    "#{extract_name(pet)}#{extrac_code(pet)}#{extract_pet_type(pet)}"
    |> :erlang.md5()
    |> Base.encode16(case: :lower)
  end
end
