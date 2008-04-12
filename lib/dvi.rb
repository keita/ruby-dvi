module Dvi
  module Version #:nodoc:
    MAJOR = 0
    MINOR = 2
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].join('.')
  end

  VERSION = Version::STRING

  class Processor
    attr_accessor :h, :v, :w, :x, :y, :z, :font, :fonts
    attr_reader :stack, :chars, :rules, :lsr
    attr_accessor :dvi_version, :numerator, :denominator, :mag
    attr_accessor :total_pages

    def initialize(lsr=Dvi::LsR.default)
      @h = 0 # horizontal position
      @v = 0 # vertical position
      @w = 0
      @x = 0
      @y = 0
      @z = 0
      @font = nil
      @stack = []
      @chars = []
      @rules = []
      @fonts = Hash.new
      @lsr = lsr
    end

    def process(opcode)
      opcode.interpret(self)
    end
  end

  class Font
    attr_reader :checksum, :scale, :design_size, :area, :name, :tfm
    def initialize(checksum, scale, design_size, area, name, tfm)
      @checksum = checksum # check sum should be same as in tfm file
      @scale = scale # scale factor
      @design_size = design_size # DVI unit
      @area = area # nil
      @name = name # font name for tfm file
      @tfm = tfm
    end
  end

  # TypesetCharacter is a class of typeset characters.
  class TypesetCharacter
    attr_reader :index, :font, :h , :v, :width
    def initialize(index, h, v, font)
      @font = font
      @h = h
      @v = v
      @index = index
    end

    def metric
      @font.tfm.char[@index]
    end
  end

  # Rule is a class for solid black rectangles.
  class Rule
    attr_reader :height, :width, :h, :v
    def initialize(h, v, height, width)
      @h = h
      @v = v
      @height = height
      @width = width
    end
  end

  # Parse a dvi file as a opcode list.
  def self.parse(io, opcodes = Opcode::BASIC_OPCODES)
    table = Hash.new
    io.extend Util

    opcodes.each do |opcode|
      opcode.range.each{|i| table[i] = opcode }
    end

    content = []

    begin
      while cmd = io.readchar do
        content << table[cmd].read(cmd, io)
      end
    rescue EOFError; end

    return content
  end

  def self.process(io, opcodes = Opcode::BASIC_OPCODES)
    ps = Processor.new
    parse(io, opcodes).each do |opcode|
      ps.process(opcode)
    end
    return ps
  end
end

require 'dvi/lsr'
require 'dvi/tfm'
require 'dvi/util'
require 'dvi/opcode'
