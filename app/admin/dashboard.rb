ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: "Этот гем написан под LSD" do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span do

          para "Статей в базе: #{Article.count}. Одобрено: #{Article.where(approved: true).count}"
          para "Пользователей в базе: #{User.count}, из них зарегистрировано сегодня: #{User.where('created_at >= ?', Time.zone.now.beginning_of_day).count}"
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
