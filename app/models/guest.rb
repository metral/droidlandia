class Guest
    include MongoMapper::Document

    key :bytes_rcvd, Integer
    key :bytes_sent, Integer
    key :hostname, String
    many :interfaces
    key :os, String
    key :ram, Integer
    key :status, String
    key :vmid, Integer
    key :vnc_port, Integer
end

class Interface
    include MongoMapper::EmbeddedDocument

    key :name, String
    key :ip, String
    key :mac, String
    key :netmask, String
    key :gateway, String
    key :subnet, Integer
end
