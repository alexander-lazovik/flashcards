require 'rails_helper'

describe Image do
  before :each do
    image1 = double("image")
    image2 = double("image")
    allow(image1).to receive(:id).and_return(1)
    allow(image1).to receive(:title).and_return('Test image 1')
    allow(image1).to receive(:url).and_return('public/1.jpg')
    allow(image2).to receive(:id).and_return(2)
    allow(image2).to receive(:title).and_return('Test image 2')
    allow(image2).to receive(:url).and_return('public/2.jpg')

    allow(Image).to receive(:search) { [image1, image2] }
  end

  it 'searches images in Flickr' do
    images = Image.search('test')
    expect(images.count).to be 2
    expect(images[0].id).to be 1
    expect(images[0].url).to eq('public/1.jpg')
  end
end
