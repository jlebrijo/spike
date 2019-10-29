module ApipieDefinitions
  extend ActiveSupport::Concern

  included do
    def_param_group :auth_headers do
      header :'access-token', '', required: true
      header :client, '', required: true
      header :uid, '', required: true
    end

    def_param_group :album do
      param :name, String, required: true
      param :content, String
      param :picture, File
    end
  end
end
