require 'rails_helper'

RSpec.describe User, type: :model do
 
  subject { User.new(:first_name => 'Tess', :last_name => 'Thornley', :email => 'tess.thornley@gmail.com', :password => 'tess', :password_confirmation => 'tess') }

  describe 'Validations' do

    context 'Presence of fields' do

      it 'is valid with valid attributes' do
        expect(subject).to be_valid
      end

      it 'is valid with valid first_name' do
        subject.first_name = nil
        expect(subject).to_not be_valid
      end

      it 'is valid with valid last_name' do
        subject.last_name = nil
        expect(subject).to_not be_valid
      end

      it 'is valid with valid email' do
        subject.email = nil
        expect(subject).to_not be_valid
      end

      it 'is valid with valid password' do
        subject.password = nil
        expect(subject).to_not be_valid
      end

      it 'is valid with valid password_confirmation' do
        subject.password_confirmation = nil
        expect(subject).to_not be_valid
      end

      it 'is valid if password and password_confirmation match' do
        expect(subject).to be_valid
      end

    end

    context 'email is unique' do 

      it 'is valid when email is unique' do
        should validate_uniqueness_of(:email).case_insensitive
      end

    end

    context 'password and password_confirmation match' do
    
      it 'is not valid when password and password_confirmation dont match' do
        subject.password_confirmation = 'sset'
        subject.save
        expect(subject).to_not be_valid
      end

    end

    context 'password must be greater than or equal to 4 characters' do

      it 'is not valid when password is less than 4 characters' do
        subject.password = 'tes'
        subject.password_confirmation = 'tes'
        subject.save
        expect(subject).to_not be_valid
      end

    end

  end

  describe '.authenticate_with_credentials' do
    
    it 'returns an instance of the user' do
      subject.save!
      expect(User.authenticate_with_credentials(subject.email, subject.password)).to be_instance_of(User)
    end

    it 'returns an instance of the user when spaces are before or after email' do
      subject.save!
      expect(User.authenticate_with_credentials(' tess.thornley@gmail.com ', subject.password)).to be_instance_of(User)
    end

    it 'returns an instance of the user when wrong case is typed in email' do
      subject.save!
      expect(User.authenticate_with_credentials('tEss.ThOrnley@Gmail.coM', subject.password)).to be_instance_of(User)
    end

  end

end
