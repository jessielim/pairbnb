
class UsersController < Clearance::UsersController

	def new
    @user = user_from_params
    render template: "users/new"
  	end

  	def edit
  	@user = current_user
  	end

  	def update
  		@user = current_user
  		if @user.update(permit_params)
  			redirect_to url_after_create
  		else
  			render 'edit'
  		end
  	end


	def create
	    @user = user_from_params

	    if @user.save
	      sign_in @user
	      redirect_back_or url_after_create
	    else
	      render template: "users/new"
	    end
	end

 	def user_from_params
	    email = user_params.delete(:email)
	    password = user_params.delete(:password)
	    first_name = user_params.delete(:first_name)
	    last_name = user_params.delete(:last_name)
	    phone = user_params.delete(:phone)
	    gender = user_params.delete(:gender)
	    birthday = user_params.delete(:birthday)
	    avatar = user_params.delete(:avatar)

	    Clearance.configuration.user_model.new(user_params).tap do |user|
	      user.email = email
	      user.password = password
	      user.first_name = first_name
	      user.last_name = last_name
	      user.phone = phone
	      user.gender = gender
	      user.birthday = birthday
	      user.avatar = avatar
	    end
 	end

 	def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  	end

  	def permit_params
  		params.require(:user).permit(:first_name,:last_name,:email,:password,:phone,:gender,:birthday,:avatar)
  	end
end 

