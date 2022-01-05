defmodule TobaccosClubWeb.LayoutView do
  use TobaccosClubWeb, :view

  def svg_image_tag(name) do
    file_path = Path.join(:code.priv_dir(:tobaccos_club), "/static/assets/images/#{name}.svg")

    content_tag(
      :span,
      raw(File.read!(file_path)),
      class: "svg-#{name}"
    )
  end
end
