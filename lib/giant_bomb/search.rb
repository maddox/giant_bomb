module GiantBomb
  class Search
    include HTTParty
    format :json
    include HTTParty::Icebox
    cache :store => 'file', :timeout => 120, :location => Dir.tmpdir
    
    base_uri 'api.giantbomb.com'

    def initialize(the_api_key)
      @api_key = the_api_key
    end
    
    def default_query_options
      {"api_key" => @api_key, "format" => 'json'}
    end
    
    
    # http://api.giantbomb.com/search/?api_key=ABCDEF123456&query=halo&resources=game&format=json
    def find_game(keywords)
      options = {"query" => keywords, "resources" => "game"}
      options.merge!(default_query_options)
      response = self.class.get("/search", :query => options)
      response["results"].collect{|r| Game.new(r, self)}
    end

    def get_game_info(game_id)
      field_list = %w{developers genres images publishers}
      options = {"field_list" => field_list.join(',')}
      options.merge!(default_query_options)
      response = self.class.get("/game/#{game_id}/", :query => options)
      Game.new(response["results"], self)
    end

    def get_game(game_id)
      response = self.class.get("/game/#{game_id}/", :query => default_query_options)
      game = Game.new(response["results"], self)
      game.loaded = true
      game
    end

  end
end