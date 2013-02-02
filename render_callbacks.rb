module Middleman
  module CoreExtensions
    module RenderCallbacks

      # Extension registered
      class << self

        # Once registered
        def registered(app)
          app.define_hook :before_render
          app.define_hook :after_render
        end
      end
    end
  end
end

::Middleman::Extensions.register(:render_callbacks, Middleman::CoreExtensions::RenderCallbacks)

module Middleman
    module Renderers
        class RedcarpetTemplate < ::Tilt::RedcarpetTemplate::Redcarpet2
            def render(*args)
                app = args[0]
                app.run_hook :before_render, @data, self
                content = super(*args)
                app.run_hook :after_render, content, self
                return content
            end
        end
    end
end