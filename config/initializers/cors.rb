Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # later change to the domain of the frontend app
    # resource '*', headers: :any, methods: [:get, :post, :patch, :put],
    # expose: [:Authorization]
    resource(
     '*',
     headers: :any,
     expose: ["Authorization"],
     methods: [:get, :patch, :put, :delete, :post, :options, :show]
    )
  end
end