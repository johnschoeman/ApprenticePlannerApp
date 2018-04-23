module StackOverflow
  class SearchParams
    ORDERING = "desc".freeze
    SORT_CRITERIA = "creation".freeze
    TAGS = "elixir".freeze
    SITE = "stackoverflow".freeze

    def initialize(date = Time.zone.today)
      @date = date
      set_params
    end

    def set_date(date)
      @date = date
    end

    def to_h
      set_params
    end

    private

    def set_params
      @params = {
        page: 1,
        page_size: 100,
        from_date: from_date,
        to_date: to_date,
        order: ORDERING,
        sort: SORT_CRITERIA,
        min: from_date,
        max: to_date,
        tagged: TAGS,
        site: SITE,
      }
    end

    def from_date
      date_to_epoch_string(@date - 365.days)
    end

    def to_date
      date_to_epoch_string(@date - 364.days)
    end

    def date_to_epoch_string(date)
      date.to_time.to_i.to_s
    end
  end
end
