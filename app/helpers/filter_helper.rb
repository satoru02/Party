module FilterHelper

  def filter_posts(query)
    @filtered_posts = Post.where("title like ?", "%#{query}%")
  end

  # def filter_users(query)
  #   @filtered_users = User.where("email like ? OR about like ? OR name like ? OR username like ?", %"#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  # end
end
