module FilterHelper

  def filter_posts(query)

    # @filtered_posts = Post.where("title like ?", "%#{query}%")

    @filtered_posts = Post.where("created_at >= :start_date AND created_at <= :end_date", { start_date: Date.today - 10, end_date: Date.today })

    # @filtered_posts = Post.where("created_at >= :start_date AND created_at <= :end_date", {start_date: Date.today - 6, end_date: Date.today})
    # @filtered_posts = Post.where("date = :specified_time", {specified_time: "1/21/2021"})
  end
end
