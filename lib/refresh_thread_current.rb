require "refresh_thread_current/version"

module RefreshThreadCurrent
  autoload :Middleware, 'refresh_thread_current/middleware'

  module_function

  def clear_all_local_variables
    clear_thread_local_variables
    clear_fiber_local_variables
  end

  def clear_thread_local_variables
    Thread.current.thread_variables.each do |key|
      Thread.current.thread_variable_set(key, nil)
    end
  end

  def clear_fiber_local_variables
    Thread.current.keys.each { |key| Thread.current[key] = nil }
  end
end
