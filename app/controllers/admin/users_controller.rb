class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render action: 'new', error: 'There was a problem saving the user.'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].empty? and params[:user][:password_confirmation].empty?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(params[:user])
      sign_in(@user, :bypass => true) if @user == current_user
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      redirect_to edit_admin_user_path(@user), alert: 'There was a problem saving the user.'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted.'
    else
      redirect_to edit_admin_user_path(@user), alert: 'There was a problem deleting the user.'
    end
  end
end
