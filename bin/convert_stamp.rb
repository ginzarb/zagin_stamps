require 'mini_magick'

MAX_WIDTH = 370
MAX_HEIGHT = 320
PADDING = 10
POSTFIX = 'stamp'
FORMAT = 'png'

file_name = ARGV[0]
output_file_name = "#{File.dirname(file_name)}/#{File.basename(file_name, '.*')}_#{POSTFIX}.#{FORMAT}"

stamp_image = MiniMagick::Image.open(file_name)
stamp_image.combine_options do |c|
  c.trim '+repage'
  c.resize "#{MAX_WIDTH - PADDING * 2}x#{MAX_HEIGHT - PADDING * 2}>"
  c.background 'None'
  c.gravity 'SouthEast'
  c.splice "#{PADDING}x#{PADDING}"
  c.gravity 'NorthWest'
  c.splice "#{PADDING}x#{PADDING}"
end

fix_height = 1 if stamp_image.height % 2 == 1
fix_wigth = 1 if stamp_image.width % 2 == 1

stamp_image.combine_options do |c|
  c.gravity 'SouthWest'
  c.background 'None'
  c.splice "#{fix_wigth}x#{fix_height}"
end

stamp_image.format FORMAT
stamp_image.write output_file_name
