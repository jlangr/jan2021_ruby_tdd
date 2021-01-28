require "rails_helper"

def scan(id, upc)
  post "/checkouts/#{id}/scan/#{upc}"
end

def scan_member_with_discount(discount)
  post "/members", params: { name: "Ji Yang", phone: "719-287-4335", discount: discount }
  post "/checkouts/#{checkout_id}/scan_member/719-287-4335"
end

RSpec.describe 'checkouts API', type: :request do

  describe "checkouts" do
    before { post "/checkouts", params: {} }
    let!(:checkout_id) { json["id"] }

    describe "successful checkout creation" do
      it "has success status" do
        expect(response).to have_http_status(201)
      end
    end

    describe "retrieving the checkout" do
      before { get "/checkouts/#{checkout_id}" }

      it "returns the checkout" do
        expect(json["id"]).to eq(checkout_id)
      end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end
    end

    describe "scanning items" do
      before {
        post "/items/", params: { upc: "12345", description: "eggs", price: 2.25 }
        post "/checkouts/#{checkout_id}/scan/12345"
      }

      it "returns item with details" do
        expect(json["description"]).to eq("eggs")
        expect(json["price"]).to eq("2.25")
      end

      it "updates checkout with item" do
        get "/checkouts/#{checkout_id}"
        expect(json["items"].count).to eq(1)
        expect(json["items"][0]["upc"]).to eq("12345")
      end
    end

    describe "scanning a member" do
      before {
        post "/members", params: { name: "Ji Yang", phone: "719-287-4335", discount: "0.123" }
        get "/checkouts/#{checkout_id}" 
      }

      it "has no member initially" do
        expect(json["member_discount"]).to be_nil
      end

      context "given a valid member scan" do
        before {
          post "/checkouts/#{checkout_id}/scan_member/719-287-4335"
        }

        context "when the checkout is retrieved" do
          before {
            get "/checkouts/#{checkout_id}" 
          }

          it "has attached member information" do
            expect(json["member_discount"]).to eq("0.123")
          end
        end
      end

      context "when an invalid member is scanned" do
        before {
          post "/checkouts/#{checkout_id}/scan_member/99999"
        }

        it "returns a 404" do
          expect(response).to have_http_status(404)
        end
      end
    end
  end

  describe "credit verification" do
    it "posts" do
      post "/checkouts/:id/charge"
    end
  end

  describe "when requesting a nonexistent checkout" do
    it "returns not found error" do
      get "/checkouts/99999"

      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Checkout/)
    end
  end

  describe "checkout totals", :only => true do
    before() do
      post "/checkouts", params: {}
    end

    context "given a discountable item has been scanned" do
      let(:discountable_upc) { "88888" }
      let(:checkout_id) { json["id"] }
      before() do
        scan_member_with_discount("0.01")
        post "/items/", params: { upc: discountable_upc, description: "Ten dollar item", price: 10.00 }
        post "/checkouts/#{checkout_id}/scan/#{discountable_upc}"
      end

      context "when a total is requested" do
        before() { get "/checkouts/#{checkout_id}/total" }

        it "returns scanned item totals" do
          expect(json["total"]).to eq "9.90"
          expect(json["total_of_discounted_items"]).to eq "9.90"
          expect(json["total_saved"]).to eq "0.10"
        end

        it "prints a receipt" do
          expect(json["messages"]).to eq([
                                           "Ten dollar item                         10.00",
                                           "   1.0% mbr disc                        -0.10",
                                           "TOTAL                                    9.90",
                                           "*** You saved:                           0.10"])
        end
      end
    end

    context "given a non-discountable item has been scanned" do
      let(:checkout_id) { json["id"] }
      let(:exempt_upc) { "99999" }
      before() do
        post "/items", params: {upc: exempt_upc, description: "One dollar item", price: 1.00, is_exempt: true }
        post "/checkouts/#{checkout_id}/scan/#{exempt_upc}"
      end

      context "when a total is requested" do
        before() { get "/checkouts/#{checkout_id}/total" }

        it "returns scanned item totals" do
          expect(json["total"]).to eq "1.00"
          expect(json["total_of_discounted_items"]).to eq "0.00"
          expect(json["total_saved"]).to eq "0.00" # hmmm
        end

        it "prints a receipt" do
          expect(json["messages"]).to eq(["One dollar item                          1.00",
                                          "TOTAL                                    1.00"])
        end
      end
    end
  end
end
