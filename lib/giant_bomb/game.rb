module GiantBomb
  class Game
    attr_accessor :id, :name, :deck, :description, :date_last_updated, :original_release_date, :site_detail_url,
                  :number_of_user_reviews, :date_added, :original_game_rating, :image
    
    def initialize(options={})
      @image = {}

      @id = options["id"]
      @name = options["name"]
      @deck = options["deck"]
      @description = options["description"]
      @site_detail_url = options["site_detail_url"]
      @number_of_user_reviews = options["number_of_user_reviews"]
      @original_game_rating = options["original_game_rating"]

      @date_last_updated = DateTime.parse(options["date_last_updated"]) if options["date_last_updated"]
      @original_release_date = DateTime.parse(options["original_release_date"]) if options["original_release_date"]
      @date_added = DateTime.parse(options["date_added"]) if options["date_added"]

      options["image"].each{|key,value| @image[key.gsub('_url', '').to_sym] = value } if options["image"]
    end
    
  end

end