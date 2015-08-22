require 'middleman-core/renderers/redcarpet'

module BacktickCodeBlock
  class << self
    AllOptions = /([^\s]+)\s+(.+?)(https?:\/\/\S+)\s*(.+)?/i
    LangCaption = /([^\s]+)\s*(.+)?/i

    def registered(app)
      app.before_render do |body, path, locs, template_class|
        if not template_class == Middleman::Renderers::RedcarpetTemplate
          next
        end

        BacktickCodeBlock.render_code_block(body)
      end

      def render_code_block(input)
        input.gsub(/^`{3} *([^\n]+)?\n(.+?)\n`{3}/m) do
          @caption = nil
          @lang = nil
          @url = nil
          @title = nil

          @options = $1 || ''
          str = $2

          if @options =~ AllOptions
            @lang = $1
            @caption = "<figcaption><span>#{$2}</span><a href='#{$3}'>#{$4 || 'link'}</a></figcaption>"
          elsif @options =~ LangCaption
            @lang = $1
            @caption = "<figcaption><span>#{$2}</span></figcaption>" if $2
          end

          if str.match(/\A( {4}|\t)/)
            str = str.gsub(/^( {4}|\t)/, '')
          end

          if @lang.nil? || @lang == 'plain' || @lang == ''
            @lang = 'text'
          end

          if @lang.include? "-raw"
            raw = "``` #{@options.sub('-raw', '')}\n"
            raw += str
            raw += "\n```\n"
          else
            code = Middleman::Syntax::Highlighter.highlight(str, @lang)
            "<figure class='code'>
              #{@caption}
              <div>
                #{code}
              </div>
            </figure>"
          end
        end
      end
    end

    alias :included :registered
  end
end

::Middleman::Extensions.register(:backtick_code_block, BacktickCodeBlock)
