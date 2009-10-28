require 'test_helper'

class GiantBombTest < Test::Unit::TestCase

  context 'GiantBomb' do
    setup do 
      @gb = GiantBomb::Search.new("key")
    end
    
    context 'getting game' do
      setup do
        stub_get('/game/9463/?format=json&api_key=key', 'mega_man_x.json')
        @game = @gb.get_game('9463')
      end
      context 'for a game' do
        
        should "return a game" do
          assert_equal GiantBomb::Game, @game.class
        end
        
        should "have a name" do
          assert_equal 'Mega Man X', @game.name
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
    end
    
    
  end
end
