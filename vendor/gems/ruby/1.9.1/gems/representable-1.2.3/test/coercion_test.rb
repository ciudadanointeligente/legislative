require 'test_helper'
require 'representable/coercion'

class VirtusCoercionTest < MiniTest::Spec
  class Song  # note that we don't define accessors for the properties here.
  end
    
  describe "Coercion with Virtus" do
    describe "on object level" do
      module SongRepresenter
        include Representable::JSON
        include Representable::Coercion
        property :composed_at, :type => DateTime 
      end
     
      it "coerces properties in #from_json" do
        song = Song.new.extend(SongRepresenter).from_json("{\"composed_at\":\"November 18th, 1983\"}")
        assert_kind_of DateTime, song.composed_at
        assert_equal DateTime.parse("Fri, 18 Nov 1983 00:00:00 +0000"), song.composed_at
      end
    end
    
    
    class ImmigrantSong
      include Representable::JSON
      include Virtus
      include Representable::Coercion
      
      property :composed_at, :type => DateTime, :default => "May 12th, 2012"
    end
    
    it "coerces into the provided type" do
      song = ImmigrantSong.new.from_json("{\"composed_at\":\"November 18th, 1983\"}")
      assert_equal DateTime.parse("Fri, 18 Nov 1983 00:00:00 +0000"), song.composed_at
    end
    
    it "respects the :default options" do
      song = ImmigrantSong.new.from_json("{}")
      assert_kind_of DateTime, song.composed_at
      assert_equal DateTime.parse("Mon, 12 May 2012 00:00:00 +0000"), song.composed_at
    end
    
  end
end
