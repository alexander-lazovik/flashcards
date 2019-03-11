class CardImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  process resize_to_fit: [360, 360]
  process convert: 'jpg'

  def extension_white_list
    %w(jpg jpeg gif png)
  end

# The following will generate hexadecimal filenames in the following format
  def filename
    "#{secure_token(10)}.#{file.extension.downcase}" if original_filename.present?
  end

  protected

# This function generates hexadecimal code and stores its value in the model.image_secure_token attribute
# to keep it unchanged in case of requesting it the next time
  def secure_token(length = 16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(length / 2))
  end
end
