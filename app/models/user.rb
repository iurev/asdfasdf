class User < ApplicationRecord
    validates_presence_of :nickname
    validates_uniqueness_of :nickname
end
