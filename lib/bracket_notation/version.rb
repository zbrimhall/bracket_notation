module BracketNotation
  module Version
    MAJOR = 0
    MINOR = 1
    MAINT = 0
    
    def self.to_s;
      return "#{MAJOR.to_s}.#{MINOR.to_s}.#{MAINT.to_s}"
    end
  end
end
