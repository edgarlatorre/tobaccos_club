defmodule TobaccosClubWeb.LayoutView do
  use TobaccosClubWeb, :view

  def svg_image_tag(name) do
    content_tag(
      :span,
      raw(File.read!("assets/static/images/#{name}.svg")),
      class: "svg-#{name}"
    )
  end
end
