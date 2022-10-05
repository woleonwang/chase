# encoding: utf-8
class InterviewReportsController < ApplicationController
  skip_before_action :require_user, only: [
                                      :create,
                                      :show,
                                    ]

  def create
    user = User.find(params[:user_id])

    fields = params.permit(
      :skill_summary,
      :skill_interviewer,
      :ability_detail,
      :ability_summary,
      :ability_interviewer,
      :live_coding_video,
      :soft_skills,
      :live_coding_skills,
      :live_coding_created_at,
      :track_records,
    )

    interview_report = user.interview_reports.new(fields)

    if interview_report.save
      render json: {
        code: 0,
      }
    else
      render json: {
        code: 100001,
        message: interview_report.errors.message,
      }
    end
  end

  def show
    interview_report = InterviewReport.find_by!(share_token: params[:id])
    profile = interview_report.user.profile
    render json: {
      code: 0,
      data: {
        profile: profile.detail,
        interview_report: {
          user_id: interview_report.user_id,
          skill_summary: interview_report.skill_summary,
          skill_interviewer: interview_report.skill_interviewer,
          ability_detail: interview_report.ability_detail,
          ability_summary: interview_report.ability_summary,
          ability_interviewer: interview_report.ability_interviewer,
          live_coding_video: interview_report.live_coding_video,
          live_coding_skills: interview_report.live_coding_skills,
          live_coding_created_at: interview_report.live_coding_created_at,
          soft_skills: interview_report.soft_skills,
          track_records: interview_report.track_records,
        },
      },
    }
  end
end
