class FarmpostsController < ApplicationController
  before_filter :correct_user,   only: :destroy
    
    
  def index
	@farmpost = Farmpost.new
	@farmposts = Farmpost.all
	@vote = Vote.new
	@uservote = current_user.votes.find_by_farmpost_id(params[:farmpost])
  end

  def create
    @farmpost = current_user.farmposts.build(params[:farmpost])
    	if @farmpost.save
   		   @vote = Vote.new
           @vote.user_id = current_user.id
           @vote.farmpost_id = @farmpost.id
           @vote.save
           redirect_to farmposts_path
           flash[:notice] = "Cool."
    	else 
    	   redirect_to farmposts_path
    	   flash[:notice] = "Something wasn't right..."
        end
  end
  
  def destroy
    @farmpost.destroy
    redirect_to farmposts_path
  end
  
  # why ":format" and not ":id"?...
  
  def upvote
   @viewpost = Farmpost.find_by_id(params[:format])
   @vote = Vote.new
   @vote.user_id = current_user.id
   @vote.farmpost_id = @viewpost.id
   if @vote.save
      redirect_to farmposts_path
      flash[:notice] = "You're in."
   else
      redirect_to farmposts_path
      flash[:notice] = "Hmmm, something went awry..."
   end
  end
  
  def downvote
  	  @uservote = current_user.votes.find_by_farmpost_id(params[:format])
  	  @uservote.destroy
  	  if @uservote.save
  	  redirect_to farmposts_path
  	  flash[:notice] = "You're out."
  	  else
  	  redirect_to farmposts_path
  	  flash[:notice] = "Hmmm, something went awry..."
  	  end
  end
  
  def view_emails
      @viewpost = Farmpost.find_by_id(params[:format])
      @creator_id = @viewpost.user_id
      @creator_user = User.find_by_id(@creator_id)
      @creator_email = @creator_user.email
      @postvote = Vote.find_all_by_farmpost_id(params[:format])
  end

  def explain
  end

  private

  def correct_user
    if current_user.admin?
       @farmpost = Farmpost.find(params[:id])
    else 
       @farmpost = current_user.farmposts.find_by_id(params[:id])
       redirect_to farmposts_path if @farmpost.nil?
    end
  end
end
