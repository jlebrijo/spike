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

# Creates an sreenshot and open it at the point you put it
SCREENSHOT_FILE = "tmp/screenshot.png"
def open_screenshot
  File.delete SCREENSHOT_FILE if File.exist? SCREENSHOT_FILE
  system "xdg-open #{save_screenshot SCREENSHOT_FILE}"
end
