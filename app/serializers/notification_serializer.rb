class NotificationSerializer
  include JSONAPI::Serializer

  set_type :notification
  attributes :id, :entry_id, :user_id, :confirmation, :title, :classification, :entry_response_id, :message_id

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
end