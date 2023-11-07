require 'rails_helper'

RSpec.describe UserSerializer do
  # instance a user object
  let(:user) do
    User.new(
      id: 1,
      name: 'Ejemplo',
      email: 'ejemplo@example.com',
      created_at: Time.now
    )
  end

  subject(:serializer) { described_class.new(user) }

  it 'serializes the user' do
    # hash with the user attributes
    serialized_user = serializer.serializable_hash

    # Expect the serialized user to have the following structure
    expect(serialized_user).to include(
      data: {
        attributes: {
          created_at: user.created_at,
          email: user.email,
          id: user.id,
          name: user.name
        },
        id: user.id.to_s,
        type: :user
      }
    )
  end

  it 'serializes the user with the expected attributes' do
    # hash with the user attributes
    serialized_user = serializer.serializable_hash

    expect(serialized_user[:data][:attributes][:created_at]).to eq(user.created_at)
    expect(serialized_user[:data][:attributes][:email]).to eq(user.email)
    expect(serialized_user[:data][:attributes][:id]).to eq(user.id)
    expect(serialized_user[:data][:attributes][:name]).to eq(user.name)
    expect(serialized_user[:data][:id]).to eq(user.id.to_s)
    expect(serialized_user[:data][:type]).to eq(:user)
    expect(serialized_user[:data][:attributes].length).to eq(4)
    expect(serialized_user[:data].length).to eq(3)
  end
end
