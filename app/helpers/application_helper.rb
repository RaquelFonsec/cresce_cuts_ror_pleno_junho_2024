
module ApplicationHelper
  def user_email(user_id)
    User.find_by(id: user_id)&.email || "Usuário desconhecido"
  end

  def diff(old_value, new_value)
    Diffy::Diff.new(old_value.to_s, new_value.to_s, context: 1).to_s(:html)
  end
end
