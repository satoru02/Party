module FilterHelper

  def filter_by_popularity
    #fix
    @filtered_posts = Post.order('RANDOM()').limit(10)
  end

  def filter_by_title(query)
    @filtered_posts = Post.where("title like ?", "%#{query}%")
  end

  def filter_by_date(query)
    if query === 'today'
      @filtered_posts = Post.where(created_at: Date.today.all_day)
    elsif query === 'week'
      @filtered_posts = Post.where("created_at >= :start_date AND created_at <= :end_date", { start_date: Date.today - gap_days, end_date: Date.today })
    elsif query === 'month'
      @filtered_posts = Post.where("created_at >= :start_date AND created_at <= :end_date", { start_date: month_first_day, end_date: Date.today })
    end
  end

  def gap_days
    day = Date.today.strftime("%A")
    if day      === "Monday";    0
      elsif day === "Tuesday";   1
      elsif day === "Wednesday"; 2
      elsif day === "Wednesday"; 3
      elsif day === "Thursday";  4
      elsif day === "Friday";    5
      elsif day === "Saturday";  6
      elsif day === "Sunday";    7
    end
  end

  def month_first_day
    today = Date.today
    first_day = Date.new(today.year, today.month, 1)
  end
end