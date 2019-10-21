require 'capybara/poltergeist'
Capybara.current_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  options = { window_size: [1300, 2000], js_errors: false }
  Capybara::Poltergeist::Driver.new(app, options)
end
Capybara.raise_server_errors = false
Capybara.server = :puma, { Silent: true }
Capybara.asset_host = 'http://localhost:3000'
