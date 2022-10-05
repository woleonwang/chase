# encoding: utf-8
class ProfilesController < ApplicationController
  def detail
    locale = params[:locale] || "zh"
    render json: {
             code: 0,
             data: current_profile.detail(locale),
           }
  end

  def upload_avatar
    avatar = params[:avatar]
    current_profile.update(avatar: avatar)
  end

  def upload_attachment
    attachment = params[:attachment]
    current_profile.update(attachment: attachment)
  end

  def update_english_skills
    attributes = params.permit(:english_level)
    if current_profile.update(attributes)
      current_profile.finish(:english_skills)
      render json: {
        code: 0,
      }
    else
      render json: {
        code: 100422,
        message: current_profile.errors,
      }
    end
  end

  def update_basic
    attributes = params.permit(:country,
                               :github_url,
                               :linkedin_url,
                               :name,
                               :phone,
                               :email,
                               :weixin,
                               :self_intro)
    if current_profile.update(attributes)
      current_profile.finish(:basic)
      render json: {
               code: 0,
             }
    else
      render json: {
               code: 100422,
               message: current_profile.errors,
             }
    end
  end

  def update_availability
    attributes = params.permit(
      :remote_work_status,
      :interested_remote_work,
      :worktime_per_week,
      :remote_work_location,
      :attitude_for_night_work,
      :lastest_of_night_work
    )
    if current_profile.update(attributes)
      current_profile.finish(:availability)
      render json: {
               code: 0,
             }
    else
      render json: {
               code: 100422,
               message: current_profile.errors,
             }
    end
  end

  def update_technical_skills
    permitted = params.permit(:current_position, :locale, :skills => [:name, :level, :years], :industries => [])
    current_position = permitted[:current_position]
    skills = permitted[:skills]
    industries = permitted[:industries]
    locale = permitted[:locale]

    begin
      ActiveRecord::Base.transaction do
        current_profile.skills.clear
        skills.each do |attributes|
          current_profile.skills.create!(attributes)
        end

        current_profile.industries.clear
        industries.each do |industry|
          current_profile.industries.create!(name: industry, locale: locale)
        end

        current_profile.update!(current_position: current_position)
        current_profile.finish("technical_skills.#{locale}")
        render json: {
                 code: 0,
               }
      end
    rescue => e
      render json: {
        code: 100422,
        message: e,
      }
    end
  end

  def update_experience
    permitted = params.permit(
      :development_experience,
      :remote_work_experience,
      :locale,
      :works => [:position, :company, :from, :to, :description, :now],
      :educations => [:degree, :school, :from, :to],
      :certifications => [:description],
    )
    works = permitted[:works]
    educations = permitted[:educations]
    certifications = permitted[:certifications]
    development_experience = permitted[:development_experience]
    remote_work_experience = permitted[:remote_work_experience]
    locale = permitted[:locale]

    begin
      ActiveRecord::Base.transaction do
        current_profile.works.clear
        works.each do |attributes|
          attributes[:locale] = locale
          if attributes[:now]
            attributes[:to] = "1970-01-01"
          end
          current_profile.works.create!(attributes.except(:now))
        end

        current_profile.educations.clear
        educations.each do |attributes|
          attributes[:locale] = locale
          current_profile.educations.create!(attributes)
        end

        current_profile.certifications.clear
        certifications.each do |attributes|
          attributes[:locale] = locale
          current_profile.certifications.create!(attributes)
        end

        current_profile.update!(
          development_experience: development_experience,
          remote_work_experience: remote_work_experience,
        )

        current_profile.finish("experience.#{locale}")

        render json: {
                 code: 0,
               }
      end
    rescue => e
      render json: {
        code: 100422,
        message: e,
      }
    end
  end

  def update_projects
    permitted = params.permit(
      :locale,
      :projects => [:name, :description, :url, skills: []],
    )
    projects = permitted[:projects]
    locale = permitted[:locale]

    begin
      ActiveRecord::Base.transaction do
        current_profile.projects.clear
        projects.each do |attributes|
          attributes[:locale] = locale
          current_profile.projects.create!(attributes)
        end

        current_profile.finish("projects.#{locale}")

        render json: {
                 code: 0,
               }
      end
    rescue => e
      render json: {
        code: 100422,
        message: e,
      }
    end
  end

  def update_web_three
    attributes = params.permit(:attitude_for_web_three, :experience_for_web_three, :understand_web_three, :reason_for_web_three)
    if current_profile.update(attributes)
      current_profile.finish(:web3)
      render json: {
        code: 0,
      }
    else
      render json: {
        code: 100422,
        message: current_profile.errors,
      }
    end
  end

  def update_salary
    attributes = params.permit(:basic_salary, :bonus_min, :bonus_max, :stock, :other_salary, :expect_salary_per_hour, :expect_salary_per_year)
    if current_profile.update(attributes)
      current_profile.finish(:salary)
      render json: {
        code: 0,
      }
    else
      render json: {
        code: 100422,
        message: current_profile.errors,
      }
    end
  end

  private

  def current_profile
    current_user.profile
  end
end
