class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :home, :login]
  def new
    @user = User.new
  end

  def index
    #@users = User.all
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml { render :xml => @users }
    #  format.json{ render :json => @users }
    #end
    redirect_to root_url
  end

  def show
    email = Base64.decode64(params[:id])
    @user = User.find_by_email(email)

    # If user not found
    if @user.nil?
      redirect_to users_path , :notice => t('users.user_not_found')
    else
      @bills_subscriptions = UserSubscription.where('user = ' + @user.id.to_s) 
      respond_to do |format|
        format.html
        format.xml { render :xml  => @user }
        format.json{ render :json => @user }
      end
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => t('users.signed_up')
    else
      render "new"
    end
  end

  def home
    @user = User.new
    if current_user
      render "welcome"
    elsif cookies.signed[:user_id]
      redirect_to log_in_path
    else
      render "home"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user,
                      :notice => t('users.user_updated') )}
        format.json { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @user.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if current_user.id.to_s === params[:id].to_s
      redirect_to users_path, :notice => t('users.you_cant_delete_yourself')
    else
      @user = User.find(params[:id])
      @user.delete

      respond_to do |format|
        format.html { redirect_to users_path, :notice => t('users.user_deleted') }
        format.json { head :no_content }
      end
    end
  end
end
