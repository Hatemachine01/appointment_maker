class ConversationController < ApplicationController

	def index
	@conversations = current_user.mailbox.conversations

	end

	def show 
	@conversation = current_user.mailbox.conversations.find(params[:id])
	end

	def new
		if current_user.status? 
		@recipients = User.all
		else
	    @recipients = User.where(status: true)
		end
	end


	def create

	recipient = User.find(params[:user_id])
	
	receipt = current_user.send_message(recipient, params[:body], params[:subject])

	redirect_to conversation_path(receipt.conversation)

	end
end