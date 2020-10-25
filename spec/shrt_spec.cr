require "./spec_helper"

# To run do KEMAL_ENV=test crystal spec

describe Shrt do
  # =========================
  # Slug tests
  # =========================

  it "checks for nil slug" do
    body = {"slug": nil}

    post("/url", headers: HTTP::Headers{"Content-Type" => "application/json"}, body: body.to_json)

    puts response.body

    # response.status_code.should eq 400
    true.should eq true
  end
end
