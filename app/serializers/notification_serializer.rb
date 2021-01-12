class NotificationSerializer
  include JSONAPI::Serializer
  attributes :id, :entry_id, :user_id, :confirmation, :title, :classification, :entry_response_id, :message_id
end