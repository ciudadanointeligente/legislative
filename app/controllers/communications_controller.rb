require 'writeit-rails'

class CommunicationsController < ApplicationController

  def index
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons'], 'application/json'
    @messages = LegislativeMessageCollection.new
    page = 1
    if !params[:page].nil?
      page = params[:page]
    end
    @messages.get page
    
    set_pagination @messages.meta
  end

  def create
    set_current_instance
  	@message = Message.new
    @message.writeitinstance = @writeitinstance
  	@message.subject = params[:subject]
    @message.content = params[:content]
    @message.recipients = params[:recipients]
    @message.remote_uri = params[:remote_uri]
    @message.remote_id = params[:remote_id]
    @message.author_name = params[:author_name]
    @message.author_email = params[:author_email]
    @message.push_to_api
  end
  def per_person
    id = params[:id]
    @person = PopitPerson.get ENV['popit_persons'] + id, 
                'application/json'
    @messages = LegislativeMessageCollection.new
    @messages.get person: @person
  end

  private
  def set_current_instance
    @writeitinstance = WriteItInstance.new
    @writeitinstance.url = ENV['writeit_url']
    @writeitinstance.base_url = ENV['writeit_base_url']
    @writeitinstance.username = ENV['writeit_username']
    @writeitinstance.api_key = ENV['writeit_api_key']
    @writeitinstance.per_page = ENV['writeit_messages_per_page']
  end
  def set_pagination meta
    @pagination = Hash.new
    @pagination['current_page'] = (meta['offset']/meta['limit']) + 1
    @pagination['total_pages'] = (meta['total_count']/meta['limit']) + 1

  end
end
