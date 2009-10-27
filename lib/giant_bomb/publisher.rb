module GiantBomb
  class Publisher
    include Attributes
    attributes :name, :id
    
    def initialize(values)
      self.attributes = values
    end
    
    def self.parse(data)
      return unless data
      if data.is_a?(Array)
        data.collect do |g|
          Publisher.new(g)
        end
      else
        [Publisher.new(data)]
      end
    end
  end
end
