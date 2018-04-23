module StackOverflowHelpers
  def stub_api_request
    response =
      { items: [{ title: "test link", link: "https://stackoverflow.com" }] }
    response_json = response.to_json
    stub_request(:get, /api.stackexchange/).
      with(headers: { "Accept" => "*/*", "User-Agent" => "Ruby" }).
      to_return(
        status: 200,
        body: response_json,
        headers: { "Content-Type" => "application/json" },
      )
  end
end
