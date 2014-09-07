module ScrapSorting
  extend ActiveSupport::Concern

  included do
  end

  # Apply sorting logic to ARel condition set
  #
  # @param [ActiveRecord::Relation] arel
  #   ARel-like object to apply sorting scope
  # @param [String] sort sorting string to match against
  #   (anything not recognized defaults to "updated_desc" functionality)
  # @return [ActiveRecord::Relation]
  def apply_sorting(arel, sort)
    case sort
    when "created_asc"  then arel.oldest
    when "created_desc" then arel.newest
    when "updated_asc"  then arel.stagnant
    when "updated_desc" then arel.lively
    else
      arel.lively
    end
  end#apply_sorting
end
