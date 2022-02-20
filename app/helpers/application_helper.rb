module ApplicationHelper
  # TODO add logic for cookies
  def current_user
    begin
      token = request.headers["Authorization"]
      token_id = decode_token(token)[0]["data"]["user_id"]
      user = User.find(token_id)
      if user
        return user
      else
        head :forbidden
        return false
      end
    rescue JWT::DecodeError
      Rails.logger.warn "Error decoding the JWT: "
    end
    head :forbidden
    false
  end

  def isMember(team)
    if team
      if team.members.include?(current_user)\
         || team.user_id == current_user.id
         #|| team.admins.include?(current_user)
        return true
      else
        return false
      end
    else
      return false
    end
  end

  # TODO add admins table and uncomment this
  # def isAdmin(team)
  #   if team
  #     if team.admins.include?(current_user) || team.user_id == current_user.id
  #       return true
  #     else
  #       return false
  #     end
  #   else
  #     return false
  #   end
  # end
end
