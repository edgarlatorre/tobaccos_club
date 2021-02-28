defmodule TobaccosClub.Services.Storage do
  alias ExAws.S3

  def generate_url(key) do
    response =
      S3.presigned_url(
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

  def upload_file(path, name) do
    bucket = Application.get_env(:ex_aws, :bucket)

    path
    |> S3.Upload.stream_file()
    |> S3.upload(bucket, name)
    |> ExAws.request!()
  end

  def get_file_content(filename) do
    bucket = Application.get_env(:ex_aws, :bucket)

    object = S3.get_object(bucket, filename)

    case ExAws.request!(object) do
      %{status_code: 200, body: body} -> body
      _ -> ""
    end
  end
end
