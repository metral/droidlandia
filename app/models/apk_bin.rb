require 'paperclip'

class ApkBin
  include MongoMapper::Document
  include Paperclip::Glue

  key :intent, String

  has_attached_file :apk, dependent: :destroy,
    :path => ':rails_root/public/system/:class/:id/:style/:basename.:extension',
    :url => '/:class/:id/:apk'
    
  key :apk_file_name, String

  validates :intent, presence: true
  validates :apk_file_name, presence: true

  timestamps!

end
