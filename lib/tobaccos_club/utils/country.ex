defmodule TobaccosClub.Utils.Country do
  alias TobaccosClub.Utils.Country
  defstruct [:name, :locale]

  def list_localized_countries do
    Enum.map(TobaccosClub.Utils.Country.list_countries(), fn c ->
      %TobaccosClub.Utils.Country{
        name: Gettext.gettext(TobaccosClubWeb.Gettext, c.name),
        locale: c.locale
      }
    end)
  end

  def list_countries_by_codes(codes) do
    list_localized_countries()
    |> Enum.filter(fn c -> Enum.member?(codes, c.locale) end)
    |> Enum.map(fn c -> c.name end)
  end

  def list_countries do
    [
      %Country{locale: "US", name: "United States"},
      %Country{locale: "DK", name: "Denmark"},
      %Country{locale: "UK", name: "United Kingdom"},
      %Country{locale: "DE", name: "Germany"},
      %Country{locale: "CA", name: "Canada"},
      %Country{locale: "SE", name: "Sweden"},
      %Country{locale: "AR", name: "Argentina"},
      %Country{locale: "AT", name: "Austria"},
      %Country{locale: "FR", name: "France"},
      %Country{locale: "TR", name: "Turkey"},
      %Country{locale: "IT", name: "Italy"},
      %Country{locale: "IE", name: "Ireland"},
      %Country{locale: "CH", name: "Switzerland"},
      %Country{locale: "BR", name: "Brazil"},
      %Country{locale: "NL", name: "Netherlands"},
      %Country{locale: "RU", name: "Russia"},
      %Country{locale: "BE", name: "Belgium"},
      %Country{locale: "PT", name: "Portugal"},
      %Country{locale: "MX", name: "Mexico"},
      %Country{locale: "JP", name: "Japan"},
      %Country{locale: "ID", name: "Indonesia"},
      %Country{locale: "ZA", name: "South Africa"},
      %Country{locale: "CZ", name: "Czech Republic"},
      %Country{locale: "GR", name: "Greece"}
    ]
  end
end
