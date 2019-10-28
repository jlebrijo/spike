require "selenium/webdriver"
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--window-size=1024,768")
  options.add_argument("--headless")
  options.add_argument("--disable-gpu")

  Capybara::Selenium::Driver.new app,
                                 browser: :chrome,
                                 options: options
end
Capybara.javascript_driver = :selenium_chrome_headless

Capybara.raise_server_errors = false
Capybara.server = :puma, { Silent: true }
Capybara.asset_host = 'http://localhost:3000'

# Creates an sreenshot and open it at the point you put it
SCREENSHOT_FILE = "tmp/screenshot.png"
def open_screenshot
  File.delete SCREENSHOT_FILE if File.exist? SCREENSHOT_FILE
  system "xdg-open #{save_screenshot SCREENSHOT_FILE}"
end
