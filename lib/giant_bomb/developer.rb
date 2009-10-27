module GiantBomb
  class Developer
    include Attributes
    attributes :name, :id
    
    def initialize(values)
      self.attributes = values
    end
    
    def self.parse(data)
      return unless data
      if data.is_a?(Array)
        data.collect do |g|
          Developer.new(g)
        end
      else
        [Developer.new(data)]
      end
    end
  end
end
