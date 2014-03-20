require 'spec_helper'

describe User do
  it "gets created" do
    u = User.create(username: "foor", password: "barter")
    expect(u.id).to eq 1
  end
end
