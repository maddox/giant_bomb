require 'test_helper'

class GiantBombTest < Test::Unit::TestCase

  context 'GiantBomb' do
    setup do 
      @gb = GiantBomb::Search.new("key")
    end

    context 'searching' do
      context 'for a game' do
        setup do
          stub_get('/search/?api_key=key&query=halo&resources=game&format=json', 'search.json')
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
          stub_get('/search/?api_key=key&query=halo&resources=game&format=json', 'search.json')
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
          assert_equal DateTime, @game.date_last_updated.class
        end

        should "have parsed original_release_date to be a real date" do
          assert_equal DateTime, @game.original_release_date.class
        end

        should "have parsed date_added to be a real date" do
          assert_equal DateTime, @game.date_added.class
        end

        context 'with an image' do

          should 'have an image hash' do
            assert_equal Hash, @game.image.class
          end

          should 'have multiple sizes for the image' do
            assert_equal 5, @game.image.keys.size
          end

          should 'have these sizes with symbols for keys' do
            assert_not_nil @game.image[:super]
            assert_not_nil @game.image[:small]
            assert_not_nil @game.image[:thumb]
            assert_not_nil @game.image[:tiny]
            assert_not_nil @game.image[:screen]
          end

        end
      end
      
      
      context 'with sketchy data' do
        setup do
          stub_get('/search/?api_key=key&query=halo2&resources=game&format=json', 'sketchy_results.json')
          @game = @gb.find_game('halo2').first
          puts @game.name
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

      end


    end
    
  end
end
