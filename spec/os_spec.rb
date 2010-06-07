require 'lib/systeminformation.rb'
describe SystemInformation::OS do
  it "should return :darwin for my current os" do
    SystemInformation::OS.os.should be :darwin
  end
end