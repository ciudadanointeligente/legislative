require 'spec_helper'
require 'popolo'

describe CongressmenController, :type => :controller  do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', locale: 'es'
      response.should be_success
    end
    it "returns one person" do
      person = Popolo::Person.create id:"12345fieraFeroz", name:"Fierita"
      get :show, :id => person.id, locale: 'es'
      response.should be_success
      assigns(:popolo_person).should_not be_nil
      assigns(:popolo_person).should be_a_kind_of Popolo::Person
      assigns(:popolo_person).id.should eq(person.id)
    end
    describe "GET 'votes'" do
      it 'routes to the thing' do
        person = Popolo::Person.create id:"12345fieraFeroz", name:"Fierita"
        get :votes, :id => person.id, locale: 'es'
        response.should be_success
      end
      it "gets votes per person" do
        person = Popolo::Person.create id:"12345fieraFeroz", name:"Fierita"
        get :votes, :id => person.id, locale: 'es'
        response.should be_success
        assigns(:popolo_person).should_not be_nil
        assigns(:popolo_person).should be_a_kind_of Popolo::Person
        assigns(:popolo_person).id.should eq(person.id)
      end
    end
    
  end
end
