class UserSerializer < ActiveModel::Serializer
  attributes :email

  attribute :jwt_token do
    scope[:token] if scope && scope[:token].present?
  end
end
