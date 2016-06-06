# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_ayanami_session'
Ayanami::Application.config.session_store :redis_store, key: '_steam_session', servers: 'redis://redis:6379/5/session', expires_in: 300.days
