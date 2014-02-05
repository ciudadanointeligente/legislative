require 'billit_representers/models/paperwork_collection'

class NotifiersController < ApplicationController

  def index
    render json: Notifier.all
  end

  def run_tasks
    last_notification = params[:date]
    @bills = bills_updated(last_notification)
    # @bills = params[:bills]
    @bills.each do |bill|
      @user_id_subscriptions = get_user_id_subscriptions(bill)
      build(bill, @user_id_subscriptions)
    end
    send_notifies
  end

  private

  def bills_updated(last_notification)
    # Returns a list of bills updated since last_notification
    @paperworks_updated_collection = Billit::PaperworkCollection.get(ENV['paperworks_url'] + 'search.json?date_min=' + last_notification, 'application/json')
    @paperworks_updated = @paperworks_updated_collection.paperworks
    @bills_updated = @paperworks_updated.map { |paperwork| paperwork.bill_uid }
  end


  def get_user_id_subscriptions(bill)
    # Given a bill, returns all the user_id_subscriptions subscribed to that bill that have confirmed.
    @bill = bill
    @users_subscribed = UserSubscription.where(bill: @bill).to_a
    @users_id_subscribed = @users_subscribed.find_all { |user| user.confirmed }.map { |user| user.user }
    @users_id_subscribed
  end


  def build(bill, users_id_subscribed)
    # It creates or updates notifiers
    @bill = bill
    @users_id_subscribed = users_id_subscribed

    @users_id_subscribed.each do |user_id|
      notifier = Notifier.find_by_user_id(user_id)
      if notifier.nil?
        Notifier.create(:user_id => user_id, :bills => [@bill])
      else
        notifier.bills << @bill
        notifier.save
      end
    end
  end

  def send_notifies
    @notifies = Notifier.all
    @time_now = Time.now()
    @notifies.each do |notify|
      # Send email
      NotifierMailer.notification_email(notify).deliver

      # Change last_notification field of user_subscription
      @user = User.find_by_id(notify.user_id)
      @user.last_notification = @time_now
      @user.save

      # Remove notify from database
      Notifier.delete_all(["user_id = ?", notify.user_id])
    end

    flash[:notice] = 'Notificaciones Enviadas!'
    redirect_to ""
  end

end
