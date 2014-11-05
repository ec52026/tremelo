require 'spec_helper'

describe User do
  let(:valid_attributes){
    {
      first_name: "Sean",
      last_name: "Winner",
      email: "sean@tremelo.com",
      password: "password1",
      password_confirmation: "password1"
    }
  }

  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "SEAN@TREMELO.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email address to look like an email" do
      user.email = "sean"
      expect(user).to_not be_valid
    end

  end

  context "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "SEAN@TREMELO.COM"))
      expect{ user.downcase_email }.to change{ user.email }.
      from("SEAN@TREMELO.COM").
      to('sean@tremelo.com')

    end

    it "downcases and email before saving" do
      user = User.new(valid_attributes)
      user.email = "SEAN@TREMELO.COM"
      expect(user.save).to be_true
      expect(user.email).to eq("sean@tremelo.com")
    end

  end

end
