class Host
    include MongoMapper::Document

    key :hostname, String
    key :interfaces, Array
    key :os, String
    key :release, String
    key :version, String

end
