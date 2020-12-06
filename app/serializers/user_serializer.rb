class UserSerializer < ActiveModel::Serializer
  attributes :email

  attribute :access_token do
    scope[:token] if scope && scope[:token].present?
  end
end
