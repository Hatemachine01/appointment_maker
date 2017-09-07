class ConversationController < ApplicationController

	def index
		@conversations = current_user.mailbox.inbox + current_user.mailbox.sentbox

	end

	def show 
		@conversation = current_user.mailbox.conversations.find(params[:id])
		@conversation.mark_as_read(current_user)
	
	end

	def new
		if current_user.status? 
			@recipients = User.all
		else
	    	@recipients = User.where(status: true)
		end
	end


	def trash
    	@conversation = current_user.mailbox.conversations.find(params[:format])
    	@conversation.move_to_trash(current_user)

    	redirect_to conversation_index_path

  	end

	
  	def untrash
  		@conversation = current_user.mailbox.conversations.find(params[:format])
    	@conversation.untrash(current_user)
    	redirect_to conversation_index_path
  	end



  	def show_trash
  		@trash = current_user.mailbox.trash

  	end


  	def show_sent
		@sent =	current_user.mailbox.sentbox
  	end


	def create
		recipient = User.find(params[:user_id])
		receipt = current_user.send_message(recipient, params[:body], params[:subject])
		redirect_to conversation_path(receipt.conversation)
	end
end