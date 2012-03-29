class Host
    include MongoMapper::Document

    key :hostname, String
    many :interfaces
    key :os, String
    key :release, String
    key :version, String

end

class Interface
    include MongoMapper::EmbeddedDocument

    key :name, String
    key :ip, String
    key :mac, String
    key :netmask, String
    key :broadcast, String
    key :bytes_sent, Integer
    key :bytes_rcvd, Integer
end
