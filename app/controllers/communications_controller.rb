require 'writeit-rails'

class CommunicationsController < ApplicationController
  caches_page :index

  def index
    @messages = Hash.new
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons'] + '?per_page=200', 'application/json'
    @congressmen.persons.sort! { |x,y| x.name <=> y.name }

    if !ENV['writeit_base_url'].blank? and !ENV['writeit_url'].blank? and !ENV["writeit_username"].blank? and !ENV["writeit_api_key"].blank? and !ENV["writeit_messages_per_page"].blank?
      @messages = LegislativeMessageCollection.new
      page = 1
      if !params[:page].nil?
        page = params[:page]
      end
      @messages.get page: page

      set_pagination @messages.meta
    end

    @title = t('layout.communication') + ' - '
  end

  def create
    if !params[:recipients].blank? and !params[:author_email].blank? and valid_email params[:author_email]
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

      flash[:notice] = t('communication.confirmation_mail_sent')
    else
      redirect_to communications_url, :notice => sprintf(t('communication.confirmation_mail_sent_fail'),params[:author_email])
    end
  end

  def per_person
    id = params[:id]
    @person = PopitPerson.get ENV['popit_persons'] + id, 'application/json'

    if not @person.id.nil?
      @messages = LegislativeMessageCollection.new
      begin
        @messages.get person: @person
      rescue
      end
    else
      render text: "404 no lo encontramos", status: 404
    end
  end

  def per_message
    id = params[:id]
    representer = LegislativeMessageRepresenter.new
    @message = representer.get id
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

  def valid_email email
    if email =~ /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
      return true
    end
    return false
  end
end
