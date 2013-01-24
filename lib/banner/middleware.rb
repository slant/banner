module Banner
  class Middleware
    def initialize(app, options={})
      @app = app
      @environments = options.fetch(:environments, [:staging])
      @message = options.fetch(:message, 'Banner')
   
      @style = {}
      @style[:width] = options.fetch(:width, 300).to_i
      @style[:color] = options.fetch(:color, '255, 255, 0')
      @style[:transparency] = options.fetch(:transparency, '0.5')
    end
   
    def call(env)
      status, headers, response = @app.call(env)
   
      content = ''
      response.each { |part| content += part }
   
      content = with_banner(content)
      content = with_style(content)
      content = Array(content)
   
      [status, headers, content]
    end
   
  protected
   
    def with_banner(content)
      match = /<body.*>/.match(content)
      unless match.nil?
        start_pos, end_pos = match.offset(0)
        content.insert(end_pos, "\n\n<div id=\"notification-banner\" onclick=\"javascript:this.style.display='none'\" title=\"Click the banner to hide it\"><span>#{@message}</span></div>")
      end
      content
    end
   
    def with_style(content)
      match = /<\/head>/.match(content)
      unless match.nil?
        start_pos, end_pos = match.offset(0)
   
        css = <<-CODE
          <style>
            div#notification-banner {
              background: rgba(#{@style[:color]}, #{@style[:transparency]});
              border-radius: 0 0 6px 6px;
              color: rgba(0, 0, 0, #{@style[:transparency]});
              cursor: pointer;
              font-weight: bold;
              left: 50%;
              line-height: 25px;
              margin-left: -#{@style[:width]/2}px;
              position: fixed;
              text-align: center;
              top: 0;
              width: #{@style[:width]}px;
            }
            div#notification-banner span {
              padding: 3px 10px;
            }
          </style>
        CODE
   
        content.insert(start_pos, css)
      end
      content
    end
  end
end

