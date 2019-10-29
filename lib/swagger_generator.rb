Apipie::SwaggerGenerator.class_eval do
  #--------------------------------------------------------------------------
  # Initialization
  #--------------------------------------------------------------------------

  def init_swagger_vars(version, lang, clear_warnings=false)

    # docs = {
    #     :name => Apipie.configuration.app_name,
    #     :info => Apipie.app_info(version, lang),
    #     :copyright => Apipie.configuration.copyright,
    #     :doc_url => Apipie.full_url(url_args),
    #     :api_url => Apipie.api_base_url(version),
    #     :resources => _resources
    # }


    @swagger = {
        swagger: '2.0',
        info: {
            title: "#{Apipie.configuration.app_name}",
            description: "#{Apipie.app_info(version, lang)}#{Apipie.configuration.copyright}",
            version: "#{version}",
            "x-copyright" => Apipie.configuration.copyright,
        },
        basePath: Apipie.api_base_url(version),
        schemes: [ "http", "https" ],
        consumes: [],
        paths: {},
        definitions: {},
        tags: [],
    }

    if Apipie.configuration.swagger_api_host
      @swagger[:host] = Apipie.configuration.swagger_api_host
    end

    if params_in_body?
      @swagger[:consumes] = ['application/json']
      @swagger[:info][:title] += " (params in:body)"
    else
      @swagger[:consumes] = ['application/x-www-form-urlencoded', 'multipart/form-data']
      @swagger[:info][:title] += " (params in:formData)"
    end

    @paths = @swagger[:paths]
    @definitions = @swagger[:definitions]
    @tags = @swagger[:tags]

    @issued_warnings = [] if clear_warnings || @issued_warnings.nil?
    @computed_interface_id = 0

    @current_lang = lang
  end

  #--------------------------------------------------------------------------
  # swagger "Params" block generation
  #--------------------------------------------------------------------------

  def swagger_params_array_for_method(method, path)

    swagger_result = []
    all_params_hash = add_missing_params(method, path)

    body_param_defs_array = all_params_hash.map {|k, v| v if !param_names_from_path(path).include?(k)}.select{|v| !v.nil?}
    body_param_defs_hash = all_params_hash.select {|k, v| v if !param_names_from_path(path).include?(k)}
    path_param_defs_hash = all_params_hash.select {|k, v| v if param_names_from_path(path).include?(k)}

    path_param_defs_hash.each{|name,desc| desc.required = true}
    add_params_from_hash(swagger_result, path_param_defs_hash, nil, "path")

    if params_in_body? && body_allowed_for_current_method
      if params_in_body_use_reference?
        swagger_schema_for_body = {"$ref" => gen_referenced_block_from_params_array("#{swagger_op_id_for_method(method)}_input", body_param_defs_array)}
      else
        swagger_schema_for_body = json_schema_obj_from_params_array(body_param_defs_array)
      end

      swagger_body_param = {
          name: 'body',
          in: 'body',
          schema: swagger_schema_for_body
      }
      swagger_result.push(swagger_body_param) if !swagger_schema_for_body.nil?

    else
      add_params_from_hash(swagger_result, body_param_defs_hash)
    end

    add_headers_from_hash(swagger_result, method.headers)

    swagger_result
  end

  def add_headers_from_hash(swagger_params_array, headers)
    headers.each do |h|
      header_swagger = {
          name: h[:name],
          in: 'header',
          required: h[:options][:required],
          description: h[:description]
      }
      swagger_params_array << header_swagger
    end
  end
end
