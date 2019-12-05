json.data do
    json.user do
      json.(@user, :id, :email)
    end
  end