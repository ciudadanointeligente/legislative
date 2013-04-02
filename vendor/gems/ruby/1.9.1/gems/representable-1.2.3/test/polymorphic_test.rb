require 'test_helper'

module PolymorphicExtender
  def self.extended(model)
    model.extend(representer_name_for(model))
  end
  
  def self.representer_name_for(model)
    PolymorphicTest.const_get("#{model.class.to_s.split("::").last}Representer")
  end
end


class PolymorphicTest < MiniTest::Spec
  class PopSong < Song
  end
  
  module SongRepresenter
    include Representable::JSON
    property :name
  end
  
  module PopSongRepresenter
    include Representable::JSON
    property :name, :from => "known_as"
  end
  
  class Album
    attr_accessor :songs
  end
  
  module AlbumRepresenter
    include Representable::JSON
    collection :songs, :extend => PolymorphicExtender
  end
  
  
  describe "PolymorphicExtender" do
    it "extends each model with the correct representer in #to_json" do
      album = Album.new
      album.songs = [PopSong.new("Let Me Down"), Song.new("The 4 Horsemen")]
      assert_equal "{\"songs\":[{\"known_as\":\"Let Me Down\"},{\"name\":\"The 4 Horsemen\"}]}", album.extend(AlbumRepresenter).to_json
    end
  end
end
