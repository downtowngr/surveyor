class NationbuilderPerson
  attr_accessor :person

  def initialize(mobile)
    response ||= $nb.call(:people, :match, mobile: mobile)

    # TODO: Handle multiple matches case better
    if response["code"] == "no_matches" && response["code"] == "multiple_matches"
      $nb.call(:people, :create, person: {mobile: mobile})
    end

    @person = response["person"]
  end

  def id
    person["id"]
  end

  def mobile
    person["mobile"]
  end

  def email
    person["email"]
  end

  def name
    "#{person["first_name"] person["last_name"]}"
  end

  def tags
    person["tags"]
  end

  def mobile_opt_out!
    $nb.call(:people, :update, id: self.id, person: {mobile_opt_in: false})
  end

  def add_tag(tag)
    $nb.call(:people, :tag_person, id: self.id, tagging: {tag: tag})
  end
end
