class Dashboard::ImagesController < Dashboard::BaseController
  def index
    @images = Image.search(params[:tags])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def select
    @url = params[:url]
    respond_to do |format|
      format.js
    end
  end
end
