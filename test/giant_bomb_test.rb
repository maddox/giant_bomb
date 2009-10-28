require 'test_helper'

class GiantBombTest < Test::Unit::TestCase

  context 'GiantBomb' do
    setup do 
      @gb = GiantBomb::Search.new("key")
    end
    
    context 'searching' do
      context 'for a game' do
        setup do
          stub_get('/search?format=json&api_key=key&resources=game&query=halo', 'search.json')
          @results = @gb.find_game('halo')
        end
        
        should "return an array" do
          assert_equal Array, @results.class
        end
    
        should "return an array of Games" do
          assert_equal GiantBomb::Game, @results.first.class
        end
      end
    end
    
    context 'Games' do
      context 'with good data' do
        setup do
          stub_get('/search?format=json&api_key=key&resources=game&query=halo', 'search.json')
          stub_get('/game/24035/?format=json&api_key=key', 'get_info.json')
                    
          @game = @gb.find_game('halo').first
        end
    
        should "have a name" do
          assert_equal 'Halo 3: ODST', @game.name
        end
    
        should "have a deck" do
          assert_not_nil @game.deck
        end
    
        should "have a description" do
          assert_not_nil @game.deck
        end
    
        should "have parsed date_last_updated to be a real date" do
          assert_equal Date, @game.date_last_updated.class
        end
    
        should "have parsed original_release_date to be a real date" do
          assert_equal Date, @game.original_release_date.class
        end
    
        should "have parsed date_added to be a real date" do
          assert_equal Date, @game.date_added.class
        end
    
        context 'with an image' do
    
          should 'cover should be an alias to image' do
            assert_equal @game.image, @game.cover
          end

          should 'have an image hash' do
            assert_equal Hash, @game.image.class
          end
    
          should 'have multiple sizes for the image' do
            assert_equal 5, @game.image.keys.size
          end
              
          should 'have these sizes with symbols for keys' do
            assert_not_nil @game.image["super_url"]
            assert_not_nil @game.image["small_url"]
            assert_not_nil @game.image["thumb_url"]
            assert_not_nil @game.image["tiny_url"]
            assert_not_nil @game.image["screen_url"]
          end
        end

        context 'lazy loaded attrs' do
          
          should 'have a genres array' do
            assert_equal Array, @game.genres.class
          end

          should 'have a developers array' do
            assert_equal Array, @game.developers.class
          end

          should 'have a publishers array' do
            assert_equal Array, @game.publishers.class
          end

          should 'have an images array' do
            assert_equal Array, @game.images.class
          end

          should 'have an images array of hashes' do
            assert_equal Hash, @game.images.first.class
          end
          
        end

      end
      
      
      context 'with sketchy data' do
        setup do
          stub_get('/search?format=json&api_key=key&resources=game&query=halo2', 'sketchy_results.json')
          @game = @gb.find_game('halo2').first
        end
        
        should 'handle not having date_added' do
          assert_nil @game.date_added
        end
          
        should 'handle not having original_release_date' do
          assert_nil @game.original_release_date
        end
          
        should 'handle not having date_last_updated' do
          assert_nil @game.date_last_updated
        end
          
        should 'handle not having image urls' do
          assert_nil @game.image
        end
      end
    
    
    end
    
  end
end
