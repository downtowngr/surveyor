class Citizen < ActiveRecord::Base
  has_many :votes
  has_many :poll_choices, through: :votes
  has_many :check_ins

  validates :phone_number, presence: true, uniqueness: true, length: {is: 10}

  normalize_attribute :phone_number do |value|
    value.match(/\w*(\d{10})/)[1]
  end

  def current_votes(poll)
    poll_choices.where(poll: poll)
  end

  def mobile_opt_out!
    get_nationbuilder_id if nationbuilder_id.nil?
    $nb.call(:people, :update, id: nationbuilder_id, person: {mobile_opt_in: false})
  end

  def add_tag(tag)
    get_nationbuilder_id if nationbuilder_id.nil?
    $nb.call(:people, :tag_person, id: nationbuilder_id, tagging: {tag: tag})
  end

  private

  def get_nationbuilder_id
    response = $nb.call(:people, :match, mobile: phone_number)

    if response["code"] == "no_matches" || response["code"] == "multiple_matches"
      person = $nb.call(:people, :create, person: {mobile: mobile})["person"]
    else
      person = response["person"]
    end

    update_attributes(
      nationbuilder_id: person["id"],
      email: person["email"],
      full_name: person["full_name"],
      mobile_opt_in: person["mobile_opt_in"]
    )
  end
end
