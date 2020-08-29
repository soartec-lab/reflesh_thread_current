module RefreshThreadCurrent
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      response = @app.call(env)
      RefreshThreadCurrent.clear_all_local_variables
      response
    rescue Exception
      RefreshThreadCurrent.clear_all_local_variables
      raise
    end
  end
end