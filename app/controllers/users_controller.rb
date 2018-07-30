class UsersController < ApplicationController
  before_action :set_user
  before_action :set_counts

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_counts
    @count = {}
    owned = Task.where(owner_id: params[:id])
    @count[:owner] = {total: owned.count}
    @count[:owner] = @count[:owner].merge(owned.group(:status).count)
    assigned = Task.where(assigned_id: params[:id])
    @count[:assigned] = {total: assigned.count}
    @count[:assigned] = @count[:assigned].merge(assigned.group(:status).count)
  end

end
