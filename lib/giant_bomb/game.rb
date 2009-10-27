module GiantBomb
  class Game
    include Attributes
    attr_reader :client
    
    attributes :id, :name, :deck, :description, :original_game_rating, :image

    attributes :number_of_user_reviews, :type => Integer
    attributes :date_last_updated, :original_release_date, :date_added, :type => Date

    attributes :genres, :lazy => :get_info!, :type => Genre
    attributes :publishers, :lazy => :get_info!, :type => Publisher
    attributes :developers, :lazy => :get_info!, :type => Developer

    attributes :images, :lazy => :get_info!

    alias_method :cover, :image
    
    def initialize(values, client)
      @client = client
      self.attributes = values
    end
    
    def get_info!
      game = client.get_game_info(self.id)
      @attributes.merge!(game.attributes) if game
      @loaded = true
    end
    
    
    
  end

end