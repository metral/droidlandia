require 'paperclip'

class ApkBin
  include MongoMapper::Document
  include Paperclip::Glue

  key :intent, String

  has_attached_file :apk
  key :apk_file_name, String

  timestamps!

end
