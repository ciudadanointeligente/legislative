class UserSubscriptionsController < ApplicationController
  before_action :set_user_subscription, only: [:show, :edit, :update, :destroy]

  # GET /user_subscriptions
  def index
    @user_subscriptions = UserSubscription.all
  end

  # GET /user_subscriptions/1
  def show
  end

  # GET /user_subscriptions/new
  def new
    @user_subscription = UserSubscription.new
  end

  # GET /user_subscriptions/1/edit
  def edit
  end

  # POST /user_subscriptions
  def create
    # It creates a user_subscription and a user (if necessary) with bill and user params 
    subscription_email = params[:user_subscription][:user]
    subscription_bill = params[:user_subscription][:bill]

    subscription_user = User.find_by_email(subscription_email)

    if subscription_user.nil?
    
      @user = User.new
      @user.username = subscription_email #TODO: change username (not use the email?)
      @user.email = subscription_email
      @password = SecureRandom.urlsafe_base64
      @user.password = @password
      @user.password_confirmation = @password
      @user.save

      @user_subscription = UserSubscription.new
      @user_subscription.bill = subscription_bill
      @user_subscription.confirmed = false
      @user_subscription.user = @user.id
      @user_subscription.save
      UserSubscriptionMailer.confirmation_email(@user_subscription).deliver
      flash[:notice] = t('user_subscriptions.confirmation_mail_sent')
      
    else

      subscription_id = subscription_user.id
      already_subscribe = already_subscribe(subscription_id, subscription_bill)

      if already_subscribe[1]
        if already_subscribe.first.confirmed == false
          flash[:notice] = t('user_subscriptions.already_subscribe')
          flash[:alert] = t('user_subscriptions.confirmation_mail_sent')
          UserSubscriptionMailer.confirmation_email(already_subscribe.first).deliver
        else
          flash[:notice] = t('user_subscriptions.already_subscribe')
        end
        redirect_to bill_path(already_subscribe.first.bill)
        return
      else
        @user_subscription = UserSubscription.new
        @user_subscription.bill = subscription_bill
        @user_subscription.confirmed = false
        @user_subscription.user = subscription_id
        @user_subscription.save
        UserSubscriptionMailer.confirmation_email(@user_subscription).deliver
        flash[:notice] = t('user_subscriptions.confirmation_mail_sent')
      end

    end
  
    redirect_to bill_path(@user_subscription.bill)
  end

  def confirmed
    # This is the controller of the link that is send to each user_subscription to confirm their mail
    @user_subscription = UserSubscription.find_by_email_token(params[:email_token])
    @user_subscription.confirmed = true
    @user_subscription.save
    if params[:ajax] == 'false'
      flash[:notice] = t('user_subscriptions.verified_mail')
      redirect_to bill_path(@user_subscription.bill)
    else
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end

  # PATCH/PUT /user_subscriptions/1
  def update
    if @user_subscription.update(user_subscription_params)
      redirect_to @user_subscription, notice: 'User subscription was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /user_subscriptions/1
  def destroy
    @user_subscription.destroy
    if params[:ajax] == 'false'
      redirect_to user_subscriptions_url, notice: 'User subscription was successfully destroyed.'
    else
      render :nothing => true, :status => 200, :content_type => 'text/html'
    end
  end

  # # DELETE /user_subscription?user_id=1
  # def unsubscribe_all
  #   @user_id = params[:user_id]
  #   @subscriptions = UserSubscription.where(user: @user_id)
  #   @subscriptions.each do |subscription|
  #     subscription.destroy
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_subscription
      @user_subscription = UserSubscription.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_subscription_params
      params.require(:user_subscription).permit(:user, :bill)
    end

    def already_subscribe(user, bill)
      # Check if user is already subscribed to bill
      if UserSubscription.where(:user => user, :bill => bill).first.nil?
        [nil, false]
      else
        [UserSubscription.where(:user => user, :bill => bill).first, true]
      end
    end

end