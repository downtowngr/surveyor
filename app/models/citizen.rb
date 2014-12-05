class Citizen < ActiveRecord::Base
  has_many :votes
  has_many :poll_choices, through: :votes
  has_many :check_ins
  has_many :listed_citizens
  has_many :lists, through: :listed_citizens

  has_and_belongs_to_many :blasts

  validates :phone_number, presence: true, uniqueness: true, length: { is: 11 }

  def localized_phone
    PhoneNumber.new(phone_number).localized
  end

  def e164_phone
    PhoneNumber.new(phone_number).e164
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

  def self.update_or_create_from_nationbuilder(person)
    phone_number = PhoneNumber.new(person["mobile"]).national

    citizen = find_by(nationbuilder_id: person["id"]) ||
              find_or_initialize_by(phone_number: phone_number)

    citizen.nationbuilder_id ||= person["id"]

    citizen.assign_attributes(
      phone_number: phone_number,
      email: person["email"],
      full_name: "#{person["first_name"]} #{person["last_name"]}".strip,
      mobile_opt_in: person["mobile_opt_in"]
    )

    citizen.save!
    citizen
  end

  private

  def get_nationbuilder_id
    response = $nb.call(:people, :match, mobile: localized_phone)

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
