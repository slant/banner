module Banner
  class Railtie < Rails::Railtie
    initializer 'banner.insert_middleware' do |app|
      app.config.middleware.use 'Banner::Middleware'
    end
  end
end

