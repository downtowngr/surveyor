class Citizen < ActiveRecord::Base
  has_many :votes
  has_many :poll_choices, through: :votes
  has_many :check_ins
  has_and_belongs_to_many :blasts

  validates :phone_number, presence: true, uniqueness: true

  # TODO: Country code should come from future Account model
  phony_normalize :phone_number, default_country_code: "US"

  # Currently assumes number is American
  def national_phone
    Phony.format(phone_number, format: :national, spaces: "")[1..-1]
  end

  def e164_phone
    Phony.format(phone_number, format: :international, spaces: "")
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
    response = $nb.call(:people, :match, mobile: national_phone)

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
