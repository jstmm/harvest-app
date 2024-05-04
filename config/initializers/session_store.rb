Rails.application.config.session_store :active_record_store, :key => '_harvest_app_session', :domain => (Rails.env.development? ? "lvh.me" : :all)
