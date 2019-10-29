# Override Swagger initialization method to customize the document
require_relative '../../lib/swagger_generator'

Apipie.configure do |config|
  config.app_name                = "LebrijoSpike"
  config.copyright               = "&copy; 2018 Lebrijo Inc."
  config.app_info["v1"]          = "Documentation for Lebrijo Api."
  config.api_base_url["v1"]      = "/"
  config.doc_base_url            = "/apidoc"
  config.default_version         = "v1"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/**/*.rb"
  config.translate               = false
  config.markup                  = Apipie::Markup::Markdown.new
  config.swagger_api_host        = 'localhost:3000'
  config.validate                = false
end
