# http://www.imagemagick.org/Usage/thumbnails/#polaroid

module Paperclip
  class Polaroider < Processor
    def initialize(file, options = {}, attachment = nil)
      super
      @file = file
      @format = File.extname(file.path)
      @basename = File.basename(file.path, @format)
    end
    
    def make
      dest = Tempfile.new("#{@basename}.#{@format}")
      
      # load a bunch of ugly hardcoded options for now
      command = []
      command.concat [file.path]
      command.concat ['-bordercolor', 'snow']
      command.concat ['-background',  'black']
      command.concat ['+polaroid']
      command.concat [dest.path]
      
      Paperclip.run 'convert', command.join(' ')

      dest      
    end
    
  end
  
end