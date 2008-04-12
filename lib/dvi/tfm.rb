require "stringio"

module Dvi
  class Tfm

    class Char
      # Returns the width(in design-size units) of the character index number.
      attr_reader :width, :height, :depth, :italic_correction
      attr_reader :kerning, :ligature
      def initialize(width, height, depth, italic_correction, kerning, ligature)
        @width = width
        @height = height
        @depth = depth
        @italic_correction = italic_correction
        @kerning = kerning
        @ligature = ligature
      end
    end

    class Ligature
      attr_reader :a, :b, :c, :index
      def initialize(a, b, c, index)
        @a = a
        @b = b
        @c = c
        @index = index
      end
    end

    class Kerning
      attr_reader :next_char, :amount
      def initialize(next_char, real_amount)
        @next_char = next_char
        @amount = real_amount * (2**(-20.0))
      end
    end

    class Data
      attr_reader :design_size, :font_coding_scheme, :font_identifier
      attr_reader :char, :param
      attr_reader :slant, :space, :strech, :shrink, :xheight, :quad, :extraspace
      def initialize(design_size, font_coding_scheme, font_identifier, char, param)
        @design_size = design_size
        @font_coding_scheme = font_coding_scheme
        @font_identifier = font_identifier
        @char = char
        @param = param
        @slant = @param[1]
        @space = @param[2]
        @stretch = @param[3]
        @shrink = @param[4]
        @xheight = @param[5]
        @quad = @param[6]
        @extraspace = @param[7]
      end
    end

    # Read the TFM file.
    # path:: TFM file path string
    def self.read(path)
      raise ArgumentError, path unless path.kind_of?(String) && File.exist?(path)
      Format.new(File.open(path)).build
    end

  end
end

require "dvi/tfm/format"
