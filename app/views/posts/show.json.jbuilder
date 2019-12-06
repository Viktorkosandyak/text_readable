json.data do
    json.user do
      json.(@post.user, :id, :email)
    end
    json.post do
      json.(@post, :id, :content, :index_readability ,:user_id)
    end
  end
  