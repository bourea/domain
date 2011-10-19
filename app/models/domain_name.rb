# == Schema Information
#
# Table name: domain_names
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  source     :string(255)
#  available  :boolean
#  registrar  :string(255)
#  created_on :date
#  updated_on :date
#  expires_on :date
#  created_at :datetime
#  updated_at :datetime
#  registered :boolean
#

class DomainName < ActiveRecord::Base
  validates :name,  :presence   => true,
                    :length     => { :maximum => 255 },
                    :uniqueness => { :case_sensitive => false }
  validates :source, :presence => true,
                    :length   => { :maximum => 255 }
  validates :available, :inclusion => { :in => [true, false] }
  validates :registered, :inclusion => { :in => [true, false] }
  validates :registrar, :presence => true
end
