class TopNotificationSerializer
  include JSONAPI::Serializer

  set_type :notification
  attributes :id, :entry_id, :user_id, :confirmation, :title, :classification, :entry_response_id, :message_id, :created_at
end