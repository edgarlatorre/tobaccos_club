defmodule TobaccosClub.TobaccosFactory do
  use ExMachina.Ecto, repo: TobaccosClub.Repo
  alias TobaccosClub.Pipes

  def brand_factory do
    %Pipes.Brand{
      name: sequence(:name, &"Brand #{&1}"),
      slug: sequence(:slug, &"brand-#{&1}")
    }
  end

  def country_factory do
    %Pipes.Country{
      name: sequence(:name, &"Country #{&1}"),
      locale: sequence(:locale, &"C#{&1}")
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
      country: build(:country),
      cut: build(:cut),
      flavouring: "None",
      image_url: "",
      manufactured_by: "some manufactured_by",
      name: sequence(:name, &"Blend #{&1}"),
      packaging: "50 grams tin, bulk",
      production: "Currently available",
      slug: sequence(:slug, &"blend-#{&1}")
    }
  end

  def cut_factory do
    %Pipes.Cut{
      name: sequence(:name, &"Cut #{&1}")
    }
  end
end
