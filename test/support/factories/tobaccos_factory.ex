defmodule TobaccosClub.TobaccosFactory do
  use ExMachina.Ecto, repo: TobaccosClub.Repo
  alias TobaccosClub.Pipes

  def brand_factory do
    %Pipes.Brand{
      name: sequence(:name, &"Brand #{&1}"),
      slug: sequence(:slug, &"brand-#{&1}")
    }
  end

  def blend_type_factory do
    %Pipes.BlendType{
      name: sequence(:name, &"Virginia #{&1}")
    }
  end

  def blend_factory do
    %Pipes.Blend{
      blended_by: "Company B",
      blend_type: build(:blend_type),
      brand: build(:brand),
      contents: "Cavendish, Latakia, Oriental/Turkish, Virginia",
      country: "UK",
      cut: "Ribbon",
      flavouring: "None",
      image_url: "",
      manufactured_by: "some manufactured_by",
      name: "My Mixture 138",
      packaging: "50 grams tin, bulk",
      production: "Currently available"
    }
  end
end
