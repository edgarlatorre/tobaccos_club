defmodule TobaccosClub.Services.Storage do
  def generate_url(key) do
    response =
      ExAws.S3.presigned_url(
        ExAws.Config.new(:s3),
        :get,
        Application.get_env(:ex_aws, :bucket),
        key
      )

    case response do
      {:ok, url} -> url
      _ -> ""
    end
  end
end
