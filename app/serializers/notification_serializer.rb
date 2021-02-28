class NotificationSerializer
  include JSONAPI::Serializer

  set_type :notification
  attributes :id, :entry_id, :user_id, :confirmation, :title, :classification, :entry_response_id, :message_id, :created_at

  attribute :entry_info do |notification, params|
    params[:entry]
  end

  attribute :entry_response_info do |notification, params|
    params[:entry_response]
  end

  attribute :post_info do |notification, params|
    params[:post]
  end

  attribute :user_info do |notification, params|
    params[:user]
  end

  attribute :message_info do |notification, params|
    params[:message]
  end

  attribute :room_info do |notification, params|
    params[:room]
  end

  attribute :index_user_info do |object|
    @index_user_info = []

    if object.classification === "entry"
      @entry = Entry.find_by(id: object.entry_id)
      @user = User.find_by(id: @entry.user.id)
    elsif object.classification === "entryResponse"
      @entryResponse = EntryResponse.find_by(id: object.entry_response_id)
      @user = User.find_by(id: @entryResponse.user.id)
    elsif object.classification === "message"
      @message = Message.find_by(id: object.message_id)
      @user = User.find_by(id: @message.user.id)
    end

    if @user.avatar.attached?
      @index_user_info.push(user: @user, avatar: @user.avatar_url(@user.avatar.blob))
    else
      @index_user_info.push(user: @user)
    end
  end
end