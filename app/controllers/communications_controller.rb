require 'writeit-rails'


class CommunicationsController < ApplicationController
  # GET /communications
  def index
    @parliamentarians = PopitPersonCollection.new
    @parliamentarians.get ENV['popit_persons'], 'application/json'
    # [fix] - improbe the ENV url for popit, actually works without http in some instances
  end
  def create
    set_current_instance
  	@message = Message.new
    @message.writeitinstance = @writeitinstance
  	@message.subject = params[:data][:subject]
    @message.content = params[:data][:content]
    @message.recipients = params[:data][:recipients]
    @message.remote_uri = params[:data][:remote_uri]
    @message.remote_id = params[:data][:remote_id]
    @message.author_name = params[:data][:author_name]
    @message.author_email = params[:data][:author_email]
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
