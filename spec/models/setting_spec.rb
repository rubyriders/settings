require 'spec_helper'

describe Setting do
  
  it 'should return nil on non-existent setting with . notation' do
    Setting.test_setting.should == nil
  end
  
  it 'should return nill on non-existent setting with [] notation' do
    Setting['test_setting'].should == nil
  end
  
  it "should have no records in db" do
    Setting.should have(:no).records
  end
  
  it "should have 1 record when setting is saved with . notation" do
    Setting.test_setting = 'test'
    Setting.should have(1).record
  end

  it "should return 'test' for test_setting with . notation" do
    Setting.test_setting = 'test'
    Setting.test_setting.should eq('test')
  end
  
  it "should return 'test' for test_setting with [] notation and string key" do
    Setting['test_setting'] = 'test'
    Setting['test_setting'].should eq('test')
  end
  
  it "should return 'test' for test_setting with [] notation and sym key" do
    Setting[:test_setting] = 'test'
    Setting[:test_setting].should eq('test')
  end
  
  it "should convert string containing numbers into number" do
    Setting[:test_setting] = '123'
    Setting[:test_setting].should eq(123)
  end
  
  it "should convert string containing floating poiny numbers into float" do
    Setting[:test_setting] = '1.23'
    Setting[:test_setting].should eq(1.23)
  end
  
  it "should convert string date formatted as DD/MM/YYYY to date" do
    Setting[:test_setting] = '01/01/2012'
    Setting[:test_setting].should eq(Date.parse('01/01/2012'))
  end
  
end
