# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  cell            :string(50)
#  sex             :integer
#  token           :string(50)
#  identity_id     :uuid
#  identity_type   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  union_id        :string
#  subscribe_at    :datetime
#  unsubscribe_at  :datetime
#  device_info     :string
#  register_status :boolean
#  register_at     :datetime
#  online_status   :boolean
#  openweb_openid  :string
#  mp_openid       :string
#  miniapp_openid  :string
#  nickname        :string
#  country         :string
#  province        :string
#  city            :string
#  headimgurl      :string
#  language        :string
#  name            :string
#

class UserSerializer < ApplicationSerializer
  attributes :dsin, :cell, :name, :nickname, :province, :city, :headimgurl
  # belongs_to :identity, polymorphic: true, optional: true, if: -> {instance_options[:include_identity]}

end
