class Post < ActiveRecord::Base
  NOT_BLANK_FIELDS = [:content, :subject]
  attr_accessible :content, :subject
  before_save :cover_blank_fields
  def cover_blank_fields
    NOT_BLANK_FIELDS.each {|field| self[field] = I18n.t("models.post.not_blank_fields.#{field}") if self[field].blank? }
  end
end
