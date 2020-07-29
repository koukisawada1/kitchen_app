module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    your_recipe = link_to 'あなたの投稿', user_path(notification), style: "font-weight: bold;"
    @visiter_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentか
    case notification.action
    when "follow"
      "あなたをフォローしました".html_safe
    when "like"
      "#{your_recipe}にいいね！しました".html_safe
    when "comment"
      "#{your_recipe}にコメントしました".html_safe
     end
    end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
   end
end
