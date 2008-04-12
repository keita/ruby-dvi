class Dvi::LsR
  def initialize(texmfdir)
    @texmfdir = texmfdir
    @table = Hash.new
    file = File.open(File.join(texmfdir, "ls-R"))
    begin
      current = nil
      while true do
        case file.readline
        when /^%/, /^$/
          # do nothing
        when /^(.*):$/
          current = $1
        when /^(.+)$/
          @table[$1] = Array.new unless @table.has_key? $1
          @table[$1] << current
        end
      end
    rescue EOFError
      file.close
    end
  end

  def find(name)
    if @table.has_key? name
      File.join(@texmfdir, @table[name].first, name)
    else
      return nil
    end
  end

  def self.default
    @default
  end

  def self.default=(lsr)
    raise ArgumentError unless lsr.kind_of?(self)
    @default = lsr
  end
end

