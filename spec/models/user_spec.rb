require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(first_name: "Tom", last_name:"Bog", email: "TomBog@123.com", password: "12345", password_confirmation: "12345")
  }

  describe 'Validations' do
    it 'should accept with all fields filled' do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to_not be_present
    end

    it 'should have a password and password_confirmation filled' do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to be_present
    end

    it 'should match the password and the password_confirmation fields' do
      subject.password = "1234"
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to be_present
    end

    it 'must be unique (not case sensitive)' do
      user1 = User.new(first_name: "Tom", last_name:"Bog", email: "TomBog@123.com", password: "123", password_confirmation: "123")
      user2 = User.new(first_name: "Tom", last_name:"Bog", email: "TomBog@123.com", password: "123", password_confirmation: "123")
      user1.save
      user2.save
      expect(user2).to_not be_valid
      expect(user2.errors.full_messages).to be_present
    end

    it 'must have Email, first name and last name' do
      subject.first_name = nil
      subject.last_name = nil
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to be_present
    end

    it 'checks that the password is greater than 5 characters' do
      user1 = User.new(first_name: "Tom", last_name:"Bog", email: "TomBog@123.com", password: "123", password_confirmation: "123")
      user1.save
      expect(user1).to_not be_valid
      expect(user1.errors.full_messages).to be_present
    end


  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate username to password' do
      User.create!(first_name: "Tom1", last_name:"Bog1", email: "TomBog@12345.com", password: "12345", password_confirmation: "12345")
      expect(User.authenticate_with_credentials("TomBog@12345.com", "12345")).to_not eq(nil)
    end
    it 'should authenticate username to password and will not log you in if its incorrect' do
      User.create!(first_name: "Tom1", last_name:"Bog1", email: "TomBog@12345.com", password: "12345", password_confirmation: "12345")
      expect(User.authenticate_with_credentials("TomBog@12345.com", "123450")).to eq(nil)
    end
    it 'should still log in if case specifics are incorrect' do
      User.create!(first_name: "Tom2", last_name:"Bog2", email: "TomBog@123456.com", password: "12345", password_confirmation: "12345")
      expect(User.authenticate_with_credentials("TOMBOG@123456.com", "12345")).to_not eq(nil)
    end
    it 'should still log in if there are spaces within the email' do
      User.create!(first_name: "Tom2", last_name:"Bog2", email: "TomBog@123456.com", password: "12345", password_confirmation: "12345")
      expect(User.authenticate_with_credentials("TOMBOG@123456.com   ", "12345")).to_not eq(nil)
    end
  end
end
