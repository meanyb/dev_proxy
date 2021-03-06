exports.config = (config) ->
  # The URI for the dev proxy server.
  # This is the URI you'll point your browser to.
  # You should definitely override this in your config file.
  config.serve "http://localhost:8080"

  # The URI of your development server.
  # This is the URI your local Rails application is running on.
  config.target "http://localhost:3000"

  # File path glob patterns.
  # All file paths matching these glob patterns will be watched for changes,
  # and when they are detected, the matching URL cache will be expired.
  config.watch "app/assets/**"
  config.watch "vendor/assets/**"

  # Match file paths to their corresponding URLs.
  # The first argument is the match pattern, and the second argument is the
  # translation function. Any captures made by the matching pattern will be
  # passed into the translation function in the order they are matched. The
  # returned URL String from the translation function will be used to expire
  # the cache for that URL.
  config.match ':location/assets/javascripts/*', javascript_path
  config.match ':location/assets/stylesheets/*', stylesheet_path
  config.match ':location/assets/images/*', images_path

  # Establish a white list of URL Strings of the paths to cache.
  # If an incoming request URL does not match an include pattern, it will not
  # be cached and will be simply reverse proxied to the server.
  config.include /\.js\?body=1$/
  config.include /\.css\?body=1$/
  config.include /\.(jpg|jpeg|gif|png|svg)$/i

  return


javascript_path = (location, filepath) ->
  return "/assets/#{filepath}?body=1"

stylesheet_path = (location, filepath) ->
  return "/assets/application.css?body=1"

images_path = (location, filepath) ->
  return "/assets/#{filepath}"
