require 'rails_helper'

describe Image do
  before :each do
    image1 = double("image")
    image2 = double("image")
    allow(image1).to receive(:id).and_return(1)
    allow(image1).to receive(:title).and_return('Test image 1')
    allow(image1).to receive(:url).and_return('spec/fixtures/1.jpg')
    allow(image2).to receive(:id).and_return(2)
    allow(image2).to receive(:title).and_return('Test image 2')
    allow(image2).to receive(:url).and_return('spec/fixtures/2.jpg')

    allow(Image).to receive(:search) { [image1, image2] }
  end

  it 'searches images in Flickr' do
    images = Image.search('test')
    expect(images.count).to be 2
    expect(images[0].id).to be 1
    expect(images[0].url).to eq('spec/fixtures/1.jpg')
  end

  it 'creates a new card with image' do
    user = create(:user)
    block =  create(:block, user: user)
    images = Image.search('test')
    image = Rails.root.join(images[0].url).open

    card = Card.create(original_text: 'дом', translated_text: 'house',
                       user_id: user.id, block_id: block.id, image: image)
    expect(card.errors.any?).to be false
  end
end
