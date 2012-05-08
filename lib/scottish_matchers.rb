require_relative "matchers"

module ScottishMatchers
  include Matchers
  alias_method :same_thingmie_as, :equal_to
  alias_method :mare_than, :greater_than
  alias_method :weer_than, :less_than
  alias_method :gonnae_see_if, :check_that
  alias_method :isnae, :is_not
  alias_method :disnae, :is_not
  alias_method :huv_lenth, :has_length
  alias_method :hus_lenth, :has_length
  alias_method :hus_coont, :has_count
  alias_method :huv_coont, :has_count
end
