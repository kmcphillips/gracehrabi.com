module DownloadHelper

  def purchase_url(purchase)
    download_url(token: purchase.token, filename: purchase.download.filename)
  end

end
