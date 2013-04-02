require 'test_helper'

class JSONBindingTest < MiniTest::Spec
  module SongRepresenter
    include Representable::JSON
    property :name
  end
  
  class SongWithRepresenter < ::Song
    include Representable
    include SongRepresenter
  end
  
  
  describe "PropertyBinding" do
    describe "#read" do
      before do
        @property = Representable::JSON::PropertyBinding.new(Representable::Definition.new(:song))
      end
      
      it "returns fragment if present" do
        assert_equal "Stick The Flag Up Your Goddamn Ass, You Sonofabitch", @property.read({"song" => "Stick The Flag Up Your Goddamn Ass, You Sonofabitch"})
        assert_equal "", @property.read({"song" => ""})
        assert_equal nil, @property.read({"song" => nil})
      end
      
      it "returns FRAGMENT_NOT_FOUND if not in document" do
        assert_equal Representable::Binding::FragmentNotFound, @property.read({})
      end
      
    end
    
    describe "with plain text" do
      before do
        @property = Representable::JSON::PropertyBinding.new(Representable::Definition.new(:song))
      end
      
      it "extracts with #read" do
        assert_equal "Thinning the Herd", @property.read("song" => "Thinning the Herd")
      end
      
      it "inserts with #write" do
        doc = {}
        assert_equal("Thinning the Herd", @property.write(doc,"Thinning the Herd"))
        assert_equal({"song"=>"Thinning the Herd"}, doc)
      end
    end
    
    describe "with an object" do
      before do
        @property = Representable::JSON::PropertyBinding.new(Representable::Definition.new(:song, :class => SongWithRepresenter))
        @doc      = {}
      end
      
      it "extracts with #read" do
        assert_equal SongWithRepresenter.new("Thinning the Herd"), @property.read("song" => {"name" => "Thinning the Herd"})
      end
      
      it "inserts with #write" do
        assert_equal({"name"=>"Thinning the Herd"}, @property.write(@doc, SongWithRepresenter.new("Thinning the Herd")))
        assert_equal({"song" => {"name"=>"Thinning the Herd"}}, @doc)
      end
    end
    
    describe "with an object and :extend" do
      before do
        @property = Representable::JSON::PropertyBinding.new(Representable::Definition.new(:song, :class => Song, :extend => SongRepresenter))
        @doc      = {}
      end
      
      it "extracts with #read" do
        assert_equal Song.new("Thinning the Herd"), @property.read("song" => {"name" => "Thinning the Herd"})
      end
      
      it "inserts with #write" do
        assert_equal({"name"=>"Thinning the Herd"}, @property.write(@doc, Song.new("Thinning the Herd")))
        assert_equal({"song" => {"name"=>"Thinning the Herd"}}, @doc)
      end
    end
  end
  
    
  describe "CollectionBinding" do
    describe "with plain text items" do
      before do
        @property = Representable::JSON::CollectionBinding.new(Representable::Definition.new(:songs, :collection => true))
      end
      
      it "extracts with #read" do
        assert_equal ["The Gargoyle", "Bronx"], @property.read("songs" => ["The Gargoyle", "Bronx"])
      end
      
      it "inserts with #write" do
        doc = {}
        assert_equal(["The Gargoyle", "Bronx"], @property.write(doc, ["The Gargoyle", "Bronx"]))
        assert_equal({"songs"=>["The Gargoyle", "Bronx"]}, doc)
      end
    end
  end
  
  
  
    
  describe "HashBinding" do
    describe "with plain text items" do
      before do
        @property = Representable::JSON::HashBinding.new(Representable::Definition.new(:songs, :hash => true))
      end
      
      it "extracts with #read" do
        assert_equal({"first" => "The Gargoyle", "second" => "Bronx"} , @property.read("songs" => {"first" => "The Gargoyle", "second" => "Bronx"}))
      end
      
      it "inserts with #write" do
        doc = {}
        assert_equal({"first" => "The Gargoyle", "second" => "Bronx"}, @property.write(doc, {"first" => "The Gargoyle", "second" => "Bronx"}))
        assert_equal({"songs"=>{"first" => "The Gargoyle", "second" => "Bronx"}}, doc)
      end
    end
    
    describe "with objects" do
      before do
        @property = Representable::JSON::HashBinding.new(Representable::Definition.new(:songs, :hash => true, :class => Song, :extend => SongRepresenter))
      end
      
      it "doesn't change the represented hash in #write" do
        song = Song.new("Better Than That")
        hash = {"first" => song}
        @property.write({}, hash)
        assert_equal({"first" => song}, hash)
      end
    end
    
  end
end
