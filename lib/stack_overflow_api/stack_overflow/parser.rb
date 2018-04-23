module StackOverflow
  class Parser
    def parse_response(response)
      parsed_response = response.parsed_response
      items = parsed_response.fetch("items", default_items)
      item = select_item(items)
      format_item(item)
    end

    private

    def format_item(item)
      { url: item["link"], title: item["title"] }
    end

    def select_item(items)
      item_with_highest_score(items)
    end

    def item_with_highest_score(items)
      items.max_by { |item| item["score"] }
    end

    def default_items
      [{ "title" => "no internet connection", "url" => "#" }]
    end
  end
end
