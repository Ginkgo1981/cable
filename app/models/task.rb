# == Schema Information
#
# Table name: tasks
#
#  id          :uuid             not null, primary key
#  name        :string
#  status      :string
#  redirect_to :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ApplicationRecord
  include BeanFamily

  def format
    {
        resource_type: 'Task',
        dsin: self.dsin,
        name: self.name,
        status: self.status,
        redirect_to: self.redirect_to
    }
  end

end
