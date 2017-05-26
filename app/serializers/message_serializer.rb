class MessageSerializer < ApplicationSerializer
  attributes :id, :dsin, :content, :created_at, :type, :student_id, :teacher_id, :university_id
  belongs_to :student
  belongs_to :university
  belongs_to :teacher

  # attribute :student
  # def student
  #   {
  #       name: object.student.name,
  #       nickname: object.student.nickname,
  #       dsin: object.student.dsin
  #   }
  # end



end
