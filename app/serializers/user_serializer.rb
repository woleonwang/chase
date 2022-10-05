class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :nickname,
    :intro,
    :company,
    :experience,
    :total_career_visible,
    :recent_placements_visible,
    :candidate_pool_visible,
    :current_jobs_visible,
  )

  attribute :avatar do
    object.avatar_url
  end
end
