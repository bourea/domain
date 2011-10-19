require 'spec_helper'

describe DomainName do

  before(:each) do
    @attr = { 
      :name => "asabour.com",
      :source => "Top 300 Verbs",
      :available => "false",
      :registered => "false",
      :registrar => "GoDaddy.com, Inc.",
      :created_on => "Sun Apr 03 00:00:00 -0400 2011",
      :updated_on => "Fri Jul 08 00:00:00 -0400 2011",
      :expires_on => "Tue Apr 03 00:00:00 -0400 2012"
    }
  end

  it "should create a new instance given valid attributes" do
    DomainName.create!(@attr)
  end

  it "should require a name" do
    no_name_domain = DomainName.new(@attr.merge(:name => ""))
    no_name_domain.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 256
    long_name_domain = DomainName.new(@attr.merge(:name => long_name))
    long_name_domain.should_not be_valid
  end

  it "should reject names identical up to case" do
    upcased_name = @attr[:name].upcase
    DomainName.create!(@attr.merge(:name => upcased_name))
    domainname_with_duplicate_name = DomainName.new(@attr)
    domainname_with_duplicate_name.should_not be_valid
  end

  it "should require a source" do
    no_source_domain = DomainName.new(@attr.merge(:source => ""))
    no_source_domain.should_not be_valid
  end

  it "should require available flag" do
    no_available_flag_domain = DomainName.new(@attr.merge(:available => ""))
    no_available_flag_domain.should_not be_valid
  end

  it "should require a registratr" do
    no_registrar_domain = DomainName.new(@attr.merge(:registrar => ""))
    no_registrar_domain.should_not be_valid
  end

  it "should not require created_on" do
    no_created_on_domain =  DomainName.new(@attr.merge(:created_on => ""))
    no_created_on_domain.should be_valid
  end

  it "should not require updated_on" do
    no_updated_on_domain =  DomainName.new(@attr.merge(:updated_on => ""))
    no_updated_on_domain.should be_valid
  end

  it "should not require expires_on" do
    no_expires_on_domain =  DomainName.new(@attr.merge(:expires_on => ""))
    no_expires_on_domain.should be_valid
  end
end
