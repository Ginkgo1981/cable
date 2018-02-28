# == Schema Information
#
# Table name: campaign_details
#
#  id          :uuid             not null, primary key
#  campaign_id :uuid
#  ord         :integer          default(0)
#  stype       :string
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CampaignDetail < ApplicationRecord
  belongs_to :campaign
  default_scope { order(:ord) }


  def format
    {
        stype: stype,
        content: content
    }
  end

  def mock


    campaign =  Campaign.find 'a2aaf013-190d-49c3-9c91-4853c4b83c43'
    [
      '原著介绍：',
      ' ',
      '海伦·凯勒出生时，本是一个健康的婴儿，却在19个月大时被一场突如其来的疾病夺去了视觉和听觉。突然变成聋盲人的海伦由于对外界的恐惧变得狂躁不安，脾气越发暴躁，直至遇到了改变她一生的家教老师——安妮·沙莉文。海伦在沙莉文老师的帮助下，凭借自己顽强的意志，最终顺利从哈佛大学毕业。 这本被誉为“世界文学史上无与伦比的杰作”的《假如给我三天光明》，就是这位美国著名聋盲女作家的代表作。该书以自传体散文的形式，真实记录了这位聋盲女性丰富、生动而伟大的一生。 在书中，海伦·凯勒完整地描述了自己富有传奇色彩的一生，以一个身残志坚的柔弱女子的视角，去告诫身体健全的人们应珍惜生命，珍惜造物主赐予的一切。',
      ' ',

      '她是一个独特的坚强的生命个体，身体上的残疾完全使她和正常的幸福生活脱离， 但是她没有没有为命运的不幸而抱怨、放弃。 她似乎就是一个奇迹，是朝阳中的一个天使。 正如她自己所说：“我的身体虽然不自由，但我的心是自由的。 还是让我的心超脱我残疾的身体而走向社会吧， 我将沉浸在无尽的喜悦中，去追求更加美好的人生！” 对于海伦，我有着无限的感情，敬佩，热爱，惊奇等等。 她就像是我在面对困难时的引路灯，让我在驾驶生命的小船上不会误入歧途， 她就像是在黑夜照亮我回家道路的星星，闪着耀眼、明亮的光芒！人生中， 我们不正要向顽强拼搏不懈的海伦-凯勒致敬学习吗？',
      ' ',
      '参与对象：',
      ' ',
      '想读英文原版书籍的朋友',
      ' ',
      '参与方式：',
      ' ',
      '分享到微信群(除百草英语群外),即可获得阅读资格,全程不收任何费用',
      ' ',
      '每天抽10分钟左右完成当日跟读闯关内容，完成当日练习题',
      ' ',
      '活动时间：',
      ' ',
      '本期课程约27天',
      ' ',
      '本课程设为闯关模式, 每天限闯一关',
      ' ',
      '活动奖励：',
      ' ',
      '全勤的同学可以获得原版电子书和音频一套！',
      ' ',
      ].each_with_index do |content, idx|
      campaign.campaign_details.create! stype: 'text',
          content: content,
          ord: idx
    end

  end
end
