class DownloadsController < FrontEndController
  def download
    purchase = Purchase.find_by_token(params[:token])

    if purchase && purchase.download.filename == params[:filename]
      begin
        purchase.record_download(request)

        send_file(purchase.download.full_path,
          filename: purchase.download.filename,
          disposition: 'attachment'
        )
      rescue => e
        ApplicationErrorJob.enqueue("Error serving download: #{ e }",
          error: e,
          params: params,
          request: request
        )
        raise e
      end
    else
      ApplicationErrorJob.enqueue("Download 404",
        params: params,
        request: request
      )
      render text: "File not found.\nContact admin@gracehrabi.com", status: 404
    end
  end
end
