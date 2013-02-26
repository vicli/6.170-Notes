class PagesController < ApplicationController
  # simply redirects to the site's show method
  def index
    @site = Site.find(params[:site_id])
    redirect_to @site
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to @page.site }
      format.json { head :no_content }
    end
  end
end
