class JvtAuthorizer
  def initialize(auth_header)
    @auth_header = auth_header
  end

  def authorize
    if (play_load = decode_token)
      user_id = play_load[0]['user_id']
      User.find_by(id: user_id)
    end
  end

  private
  def decode_token
    if @auth_header
      begin
        JvtCoder.decode(@auth_header)
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
