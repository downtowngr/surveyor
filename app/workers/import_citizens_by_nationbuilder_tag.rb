class ImportCitizensByNationbuilderTag
  include Sidekiq::Worker

  def perform(list_id, tag, page=1)
    begin
      response = $nb.call(:people_tags, :people, tag: tag, page: page, per_page: 100)
      @list = List.find(list_id)

      create_citizens(response["results"])
      page += 1
    end until response["next"].nil?
  end

  private

  def create_citizens(results)
    results.each do |person|
      unless person["mobile"].empty? || person["mobile_opt_in"] == false
        citizen = Citizen.update_or_create_from_nationbuilder(person)
        @list.citizens << citizen
      end
    end
  end
end
