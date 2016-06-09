require 'trashed/railtie'
require 'statsd'


if ENV['STATSD_PROFILER'] and ENV['STATSD_PROFILER'].to_s.downcase == 'true'
  Ayanami::Application.config.trashed.statsd = Statsd.new('graphite')
  Ayanami::Application.config.trashed.timing_dimensions = ->(env) do
    # Rails 3 and 4 set this. Other Rack endpoints won't have it.
    if (controller = env['action_controller.instance'])
      name    = controller.controller_name
      action  = controller.action_name
      format  = controller.rendered_format || :none
      variant = controller.request.variant || :none  # Rails 4.1+ only!

      [ :All,
        :"Controllers.#{name}",
        :"Actions.#{name}.#{action}.#{format}+#{variant}" ]
    end
  end
end
