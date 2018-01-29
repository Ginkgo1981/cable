# == Schema Information
#
# Table name: user_books
#
#  id         :uuid             not null, primary key
#  user_id    :uuid
#  book_id    :uuid
#  begin_at   :date
#  end_at     :date
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserBook < ApplicationRecord

  belongs_to :user
  belongs_to :book

%w(

  oRFG9jha9C5Xt-RHhtyKyilOJg0U
  oRFG9jsa3Y0JY2qXEvXAqebSijqA
  oRFG9jinqI1SeT6Lutm-Q_yAs9zw
  oRFG9jjALhvKpG20BQTFwTKNa70s
  oRFG9jk_ph0eNNnMbraWElzw7QZA
  oRFG9jvAvvf94LV0iMAhuU2y7NSk
  oRFG9jrQr5eRdfx9GquZjaCcqcv4
  oRFG9jvNXwOEus20R7tD5_SXZoas
  oRFG9juemgsgSDABp0sPwly2QpEc
  oRFG9jqfcuEhGdSllkq1VwtlVs9g
  oRFG9jqBZ-zlbYvNY1EU14lU7RG0
  oRFG9jnQ_VvGEaSzSAlgz5EtxYcM
  oRFG9jkc7-6QXlqXIkSEJngqQe_w
  oRFG9jjNsJNa9KXdB_VVx4duEXlM
  oRFG9jjnhmhoKcVTfLcA-6nDDXdw
  oRFG9jqtWUemLP5FCSkNprZVykOA
  oRFG9jnyTspCZsDiE_5i4zXa2CxM
  oRFG9jh1OUd5O-fLb_FYjQuUi3wY

).each do |open_id|

  cv = CustomValue.find_by value: open_id
  cv.value='mocked-open-id'
  cv.save

end

end
