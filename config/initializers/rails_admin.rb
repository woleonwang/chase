RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    # show_in_app do
    #   controller do
    #     proc do
    #       if @object.is_a? Article
    #         redirect_to @object.show_in_app_url
    #       else
    #         redirect_to main_app.url_for(@object)
    #       end
    #     end
    #   end
    # end

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model InterviewReport do
    show do
      configure :share_token do
        pretty_value do
          bindings[:object].share_token_url
        end
      end
    end
  end

  config.model Profile do
    list do
      configure :name do
        pretty_value do
          "<a target='_blank' href='#{ENV["frontend_host"] || "https://landd.co"}/developers/profile?admin_token=#{bindings[:object].class.admin_token}&user_token=#{JWT.encode({ id: bindings[:object].user_id }, "woleon", "HS256")}'>#{bindings[:object].name}</a>".html_safe
        end
      end
    end
  end
end
