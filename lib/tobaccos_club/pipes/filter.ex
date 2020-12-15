defmodule TobaccosClub.Pipes.Filter do
  defstruct [:blend_type_ids, :country_ids, :cut_ids, :search_text, :starts_with]

  def build do
    %TobaccosClub.Pipes.Filter{
      blend_type_ids: [],
      country_ids: [],
      cut_ids: [],
      search_text: "",
      starts_with: ""
    }
  end

  def filter_by_name(filter, name) do
    case name do
      "cut_ids" -> filter.cut_ids
      "blend_type_ids" -> filter.blend_type_ids
      "country_ids" -> filter.country_ids
      "search_text" -> filter.search_text
      "starts_with" -> filter.starts_with
    end
  end
end
