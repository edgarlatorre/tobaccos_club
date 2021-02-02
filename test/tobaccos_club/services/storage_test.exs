defmodule TobaccosClub.Services.StorageTest do
  use TobaccosClub.DataCase
  alias TobaccosClub.Services.Storage

  describe "Storage functions" do
    test "generate_url/1 returns presigned url" do
      assert "https://s3.eu-central-1.amazonaws.com/tobaccos_test/test.png" <> _params =
               Storage.generate_url("test.png")
    end
  end
end
