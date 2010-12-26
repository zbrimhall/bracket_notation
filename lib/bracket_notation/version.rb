module BracketNotation
  module Version
    MAJOR = 0 unless const_defined? :MAJOR
    MINOR = 1 unless const_defined? :MINOR
    MAINT = 0 unless const_defined? :MAINT
    
    def self.to_s;
      return "#{MAJOR.to_s}.#{MINOR.to_s}.#{MAINT.to_s}"
    end
  end
end
