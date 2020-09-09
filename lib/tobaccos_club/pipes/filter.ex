defmodule TobaccosClub.Pipes.Filter do
  defstruct [:blend_type_ids, :search_text, :starts_with]

  def build do
    %TobaccosClub.Pipes.Filter{blend_type_ids: [], search_text: "", starts_with: ""}
  end
end
