class Profile < ApplicationRecord
  belongs_to :user

  has_many :skills
  has_many :industries
  has_many :works
  has_many :educations
  has_many :certifications
  has_many :projects
  has_many :bc_skills

  mount_uploader :avatar, FileUploader
  mount_uploader :attachment, FileUploader

  def detail(locale = :zh)
    {
      # basic
      country: self.country,
      github_url: self.github_url,
      linkedin_url: self.linkedin_url,
      name: self.name,
      phone: self.phone.presence || self.user.phone,
      self_intro: self.self_intro,
      avatar: self.avatar_url,
      attachment: self.attachment_url,
      email: self.email,
      weixin: self.weixin,
      # english skills
      english_level: self.english_level,
      # availability
      remote_work_status: self.remote_work_status,
      interested_remote_work: self.interested_remote_work,
      worktime_per_week: self.worktime_per_week,
      remote_work_location: self.remote_work_location,
      attitude_for_night_work: self.attitude_for_night_work,
      lastest_of_night_work: self.lastest_of_night_work,
      # technical skills
      current_position: self.current_position,
      industries: self.industries_data(locale),
      skills: self.skills_data,
      # experience
      development_experience: self.development_experience,
      remote_work_experience: self.remote_work_experience,
      works: self.works_data(locale),
      educations: self.educations_data(locale),
      certifications: self.certifications_data(locale),
      # project
      projects: self.projects_data(locale),
      # web3
      attitude_for_web_three: self.attitude_for_web_three,
      experience_for_web_three: self.experience_for_web_three,
      understand_web_three: self.understand_web_three,
      reason_for_web_three: self.reason_for_web_three,
      # salary
      basic_salary: self.basic_salary,
      bonus_min: self.bonus_min,
      bonus_max: self.bonus_max,
      stock: self.stock,
      other_salary: self.other_salary,
      expect_salary_per_hour: self.expect_salary_per_hour,
      expect_salary_per_year: self.expect_salary_per_year,
      # other
      meta: {
        finish_percent: self.finishPercent(locale),
        current_step: self.current_step(locale),
        role: self.user.role,
      },
    }
  end

  def finish(key)
    stepsData = JSON.parse(self.steps) rescue {}
    stepsData[key] = Time.current.to_s
    self.update(steps: stepsData.to_json)
  end

  def finish_basic?
    stepsData = JSON.parse(self.steps) rescue {}
    !!stepsData["basic"]
  end

  # 当前需要填哪一步
  def current_step(locale)
    if self.user.role == "developer"
      stepsData = JSON.parse(self.steps) rescue {}
      # technical_skills.zh, experience.zh, projects.zh 有语言之分
      keys = ["english_skills", "basic", "availability", "technical_skills", "experience", "projects", "web3", "salary"]
      keys.each do |key|
        if !(stepsData[key] || stepsData["#{key}.#{locale}"])
          return key
        end
      end
      return nil
    else
      return nil
    end
  end

  def finishPercent(locale)
    if self.user.role == "recommend"
      finish_basic? ? 1 : 0
    else
      stepsData = JSON.parse(self.steps) rescue {}
      # technical_skills.zh, experience.zh, projects.zh 有语言之分
      keys = ["english_skills", "basic", "availability", "technical_skills", "experience", "projects", "web3", "salary"]
      total = keys.length
      finished = 0
      keys.each do |key|
        if stepsData[key] || stepsData["#{key}.#{locale}"]
          finished += 1
        end
      end
      (finished.to_f / total).round(2)
    end
  end

  def industries_data(locale)
    self.industries.where(locale: locale).map do |industry|
      {
        locale: industry.locale,
        name: industry.name,
      }
    end
  end

  def skills_data
    self.skills.map do |skill|
      {
        name: skill.name,
        years: skill.years,
        level: skill.level,
      }
    end
  end

  def is_now(date)
    date && date.strftime("%Y-%m-%d") == "1970-01-01"
  end

  def works_data(locale)
    self.works.where(locale: locale).map do |work|
      {
        position: work.position,
        company: work.company,
        from: work.from,
        to: is_now(work.to) ? nil : work.to,
        now: is_now(work.to),
        description: work.description,
      }
    end
  end

  def educations_data(locale)
    self.educations.where(locale: locale).map do |education|
      {
        degree: education.degree,
        school: education.school,
        from: education.from,
        to: education.to,
      }
    end
  end

  def certifications_data(locale)
    self.certifications.where(locale: locale).map do |certification|
      {
        description: certification.description,
      }
    end
  end

  def projects_data(locale)
    self.projects.where(locale: locale).map do |project|
      {
        name: project.name,
        description: project.description,
        url: project.url,
        skills: JSON.parse(project.skills),
      }
    end
  end

  class << self
    def admin_token
      "59b8902fbce6353575d8c3626f36b18f"
    end
  end
end
