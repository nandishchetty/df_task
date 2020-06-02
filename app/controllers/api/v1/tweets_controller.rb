class Api::V1::TweetsController < Api::V1::BaseController
	before_action :find_tweet, :check_role, only: [ :update, :destroy ]

	def create
		tweet = current_user.tweets.new(tweet_params)
		if tweet.save
      render json: {sucess: true, id: tweet.id}, status: :created
		else
      respond_with_error(tweet.errors.full_messages.join(', '), :unprocessable_entity, tweet.errors)
		end
	end

	def update
		if @tweet.update(tweet_params)
      render json: {sucess: true}, status: :ok
		else
      respond_with_error(@tweet.errors.full_messages.join(', '), :unprocessable_entity, @tweet.errors)
		end
	end

	def destroy
    if @tweet.destroy
    	render json: { sucess: true}, status: :ok
    else
      respond_with_error(@tweet.errors.full_messages.join(', '), :unprocessable_entity, @tweet.errors)
	  end
  end

	private

  def tweet_params
    params.require(:tweet).permit(:description)
  end

  def find_tweet
  	@tweet = current_user.tweets.find(params[:id])
  end

  def check_role
  	if current_user.is_admin?
  		true
  	else
  		render json: { message: 'not authorised'}, status: :ok
  	end
  end

end
