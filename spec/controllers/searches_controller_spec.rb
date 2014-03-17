require 'spec_helper'

describe SearchesController do
  describe "GET index" do
    it "returns a BillCollectionPage" do
      get :index, {q: 'arica', locale: 'es'}
      assigns(:bills_query).should be_an_instance_of Billit::BillCollectionPage
    end

    it "returns an array of Bills" do
      get :index, q: 'arica', locale: 'es'
      assigns(:bills_query).bills.should_not be_nil
      assigns(:bills_query).bills.should be_an Array
      assigns(:bills_query).bills[0].should be_an_instance_of Billit::Bill
    end

    it "has a self reference" do
      get :index, q: 'arica', locale: 'es'
      assigns(:bills_query).self.should_not be_nil
      assigns(:bills_query).self.should eq(ENV['billit_url'] + "search.json?&page=1&per_page=3&q=arica")
    end

    it "has a next page" do
      get :index, q: 'arica', per_page: '2', locale: 'es'
      assigns(:bills_query).next.should eq(ENV['billit_url'] + "search.json?&page=2&per_page=3&q=arica")
    end

    it "has a previous page" do
      get :index, q: 'arica', locale: 'es', page: 2
      assigns(:bills_query).previous.should eq( ENV['billit_url'] + "search.json?&page=1&per_page=3&q=arica")
    end

    it "has all metadata" do
      get :index, q: 'arica', locale: 'es'
      assigns(:bills_query).total_entries.should_not be_nil
      assigns(:bills_query).current_page.should_not be_nil
      assigns(:bills_query).total_pages.should_not be_nil
    end

    it "it obtains authors list" do
      get :index, locale: 'es'
      assigns(:authors_list).should_not be_nil
      assigns(:authors_list).should_not be_empty
    end
  end
end
