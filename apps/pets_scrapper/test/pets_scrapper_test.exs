defmodule PetsScrapperTest do
  use ExUnit.Case
  doctest PetsScrapper

  test "greets the world" do
    assert PetsScrapper.hello() == :world
  end
end
