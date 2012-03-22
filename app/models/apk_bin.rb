require 'paperclip'

class ApkBin
  include MongoMapper::Document
  include Paperclip::Glue

  key :intent, String

  has_attached_file :apk, dependent: :destroy
  key :apk_file_name, String

  validates :intent, presence: true
  validates :apk_file_name, presence: true

  timestamps!

end
