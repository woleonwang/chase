# encoding: utf-8
class RecruiterFormsController < ApplicationController
  def create
    fields = params.permit(
      :company,
      :email,
      :headcount,
      :hire_positions,
      :name,
      :phone,
      :position,
      :staff_count,
      :website,
      :wechat,
    )

    form = RecruiterForm.new(fields)

    if form.save
      render json: {
        code: 0,
      }
    else
      render json: {
        code: 100001,
        message: form.errors.message,
      }
    end
  end
end
