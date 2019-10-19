defmodule Builders.AlbergueGranCanaria do
  def build_json(pets) do
    Enum.map(pets, fn pet -> build_pet_info_json(pet) end)
  end


  defp build_pet_info_json(pet) do
    %{
      name: extract_name(pet),
      email: "",
      kind: extract_pet_type(pet),
      status: "Buscando casa",
      breed: extract_breed(pet),
      size: extrac_size(pet),
      location: "Camino Rosa Silva, 61, 35415 Bañaderos, Las Palmas, España",
      latitud: 28.1414502,
      longitud: -15.5045266,
      pet_card_url: build_card_url(pet), #  we need to this field to items table
      info: build_info(pet),
      image: build_image_url,
      age: extract_age(pet), #  we need to this field to items table
      sex: extract_sex(pet), #  we need to this field to items table
      character: extrac_character(pet), #  we need to this field to items table
      pet_code: extrac_code(pet), #  we need to this field to items table
      checksum: build_checksum(pet) #  we need to this field to items table
    }
  end

  defp build_info(pet) do
    """
    #{extract_name(pet)} es un #{extract_pet_type(pet)} que se encuentras actualmente
    en el albergue insular de animales de las palmas de gran canaria. Para mas informacion
    le rogamos que se ponga en contacto con el albergue a travez del siguiente enlace:
    #{build_card_url(pet)}
    """
  end

  defp build_card_url(pet) do
    "https://www.alberguegrancanaria.com/animal/#{extrac_code(pet)}"
  end

  defp build_image_url do
    # we need to somehow bild the url where the image will be located.
    # alternatively we could use the image url from albergue website
  end

  defp extract_name(pet) do
    pet
      |> Floki.find("h2")
      |> Floki.find("span")
      |> Floki.text
  end

  defp extrac_code(pet) do
    pet
      |> Floki.find("div.codigo_ficha")
      |> Floki.text
  end

  def extract_breed(pet) do
    pet
      |> Floki.find("div.item_ficha")
      |> Enum.at(0)
      |> Floki.find("div.wrapper-entidad div")
      |> Floki.text
  end

  def extract_age(pet) do
    pet
      |> Floki.find("div.item_ficha")
      |> Enum.at(2)
      |> Floki.find("div.wrapper-entidad div")
      |> Floki.text
  end

  def extract_sex(pet) do
    pet
      |> Floki.find("div.item_ficha")
      |> Enum.at(3)
      |> Floki.find("div.wrapper-entidad  div")
      |> Floki.text
  end

  def extrac_size(pet) do
    pet
      |> Floki.find("div.item_ficha")
      |> Enum.at(4)
      |> Floki.find("div.wrapper-entidad div")
      |> Floki.text
  end

  def extrac_character(pet) do
    pet
      |> Floki.find("div.item_ficha")
      |> Enum.at(7)
      |> Floki.find("div.wrapper-entidad div")
      |> Floki.text
  end

  def extract_pet_type(pet) do
    pet
      |> Floki.find("div.item_ficha")
      |> Enum.at(0)
      |> Floki.find("div.wrapper-entidad")
      |> Floki.find("strong")
      |> Floki.text
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
