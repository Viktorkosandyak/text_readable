json.data do
  json.posts do
    json.array!(@posts.includes(:user)) do |post|
      json.(post.user, :email)
      json.extract! post, :id, :content, :index_readability, :user_id
    end
  end
end
