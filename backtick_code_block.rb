require 'middleman-core/renderers/redcarpet'
require 'middleman-syntax/extension'

module BacktickCodeBlock
  class << self
    include Middleman::Syntax::MarkdownCodeRenderer

    AllOptions = /([^\s]+)\s+(.+?)(https?:\/\/\S+)\s*(.+)?/i
    LangCaption = /([^\s]+)\s*(.+)?/i

    def registered(app)
      # print app.methods
      app.before_render do |content, renderer|
        if not renderer.is_a?(Middleman::Renderers::RedcarpetTemplate)
          next
        end

        replacement = BacktickCodeBlock.render_code_block(content)
        content.replace(replacement)
      end
    end

    def render_code_block(input)
      @options = nil
      @caption = nil
      @lang = nil
      @url = nil
      @title = nil
      input.gsub(/^`{3} *([^\n]+)?\n(.+?)\n`{3}/m) do
        @options = $1 || ''
        str = $2

        if @options =~ AllOptions
          @lang = $1
          @caption = "<figcaption><span>#{$2}</span><a href='#{$3}'>#{$4 || 'link'}</a></figcaption>"
        elsif @options =~ LangCaption
          @lang = $1
          @caption = "<figcaption><span>#{$2}</span></figcaption>"
        end

        if str.match(/\A( {4}|\t)/)
          str = str.gsub(/^( {4}|\t)/, '')
        end

        if @lang.nil? || @lang == 'plain'
          @lang = 'text'
        end

        if @lang.include? "-raw"
          raw = "``` #{@options.sub('-raw', '')}\n"
          raw += str
          raw += "\n```\n"
        else
          code = self.block_code(str, @lang)
          "<figure class='code'>#{@caption}#{code}</figure>"
        end
      end
    end

    alias :included :registered
  end
end

::Middleman::Extensions.register(:backtick_code_block, BacktickCodeBlock) 
