# encoding: utf-8
class UploadFilesController < ApplicationController
  def create
    fields = params.permit(
      :file
    )

    upload_file = UploadFile.new(fields)

    if upload_file.save
      render json: {
        code: 0,
        data: {
          url: upload_file.file_url,
        },
      }
    else
      render json: {
        code: 100001,
        message: upload_file.errors.message,
      }
    end
  end
end
