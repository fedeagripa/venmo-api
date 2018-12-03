# encoding: utf-8

module Api
  module V1
    class UsersController < Api::V1::ApiController
      helper_method :user

      def show; end

      def profile
        render :show
      end

      def update
        user.update!(user_params)
        render :show
      end

      def balance
        render json: { balance: user.balance }
      end

      def feed
        @payments = Kaminari.paginate_array(user.friends.map(&:payments)).page(pagination).per(5)
        render json: { payments: @payments }
      end

      def payment
        receiver = User.find(params[:friend_id])
        Payment.create!(user: user, receiver: receiver, amount: params[:amount], description: params[:description])
        MoneyTransferService.new(user, receiver).transfer(params[:amount])
        head :ok
      end

      private

      def user_params
        params.require(:user).permit(:username, :first_name, :last_name, :email)
      end

      def user
        @user ||= user_id.present? ? User.find(user_id) : current_user
      end

      def user_id
        params[:id]
      end

      def pagination
        params[:page] || 1
      end
    end
  end
end
