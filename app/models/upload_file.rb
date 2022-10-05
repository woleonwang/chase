class UploadFile < ApplicationRecord
  mount_uploader :file, FileUploader
end
