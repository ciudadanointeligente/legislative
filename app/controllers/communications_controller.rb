require 'writeit-rails'

class CommunicationsController < ApplicationController

  # GET /communications
  def index
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons'], 'application/json'
    @messages = LegislativeMessageCollection.new
    @messages.get
    # [fix] - improbe the ENV url for popit, actually works without http in some instances
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

  private
  def set_current_instance
    @writeitinstance = WriteItInstance.new
    @writeitinstance.url = ENV['writeit_url']
    @writeitinstance.base_url = ENV['writeit_base_url']
    @writeitinstance.username = ENV['writeit_username']
    @writeitinstance.api_key = ENV['writeit_api_key']
  end
end
