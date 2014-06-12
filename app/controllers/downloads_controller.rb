class DownloadsController < ApplicationController
  def download
    purchase = Purchase.find_by_token(params[:token])

    if purchase && purchase.download.filename == params[:filename]
      send_file(purchase.download.full_path,
        filename: purchase.download.filename,
        disposition: 'attachment'
      )
    else
      ApplicationErrorJob.enqueue("Download 404",
        params: params,
        request: request
      )
      render text: "File not found\nContact admin@gracehrabi.com", status: 404
    end
  end
end
