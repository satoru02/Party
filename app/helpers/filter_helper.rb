module FilterHelper

  def filter_by_title(query)
    @filtered_posts = Post.where("title like ?", "%#{query}%")
  end

  def filter_by_date(query)
    if query === 'today'
      @filtered_posts = Post.where("created_at >= :start_date AND created_at <= :end_date", { start_date: Date.today, end_date: Date.today })
    elsif query === 'week'
      @filtered_posts = Post.where("created_at >= :start_date AND created_at <= :end_date", { start_date: Date.today - 6, end_date: Date.today })
    elsif query === 'month'
      # @filtered_posts = Post.where("created_at >= :start_date AND created_at <= :end_date", { start_date: Date.today, end_date: Date.today })
    end
  end
end

    # @filtered_posts = Post.where("date = :specified_time", {specified_time: "1/21/2021"})