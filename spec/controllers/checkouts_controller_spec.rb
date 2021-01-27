require "rails_helper"

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
    before do
      create_non_exempt_items
      create_member
      create_checkout
      assign_member_to_checkout
      scan_non_exempt_items
    end

    context 'member discountable items' do
      it 'calculates the checkout total' do
        get "/checkouts/#{@checkout_id}/total"

        expect(json["total"]).to eq "12.13"
      end
    end

    context 'member discountable and not member discountable items' do
      before do
        post "/items", params: {upc: "92311", description: "PowerBall ticket with SuperScam option", price: 10.50, is_exempt: true }
        post "/checkouts/#{@checkout_id}/scan/92311"
        get "/checkouts/#{@checkout_id}/total"
      end

      it 'updates total after scanning an additional item' do
        expect(json["total"]).to eq "22.63"
      end

      it 'discounts only non-exempt items' do
        expect(json["total_of_discounted_items"]).to eq "12.13"
      end

      it 'sums the total saved with member discount' do
        expect(json["total_saved"]).to eq "0.37"
      end

      it "provides an itemized receipt" do
        expect(json["messages"]).to eq([
          "Kellogs Bran Flakes Family Size 24oz     4.72",
          "   3.0% mbr disc                        -0.14",
          "Pescanova Smelt Headless - 16oz          7.78",
          "   3.0% mbr disc                        -0.23",
          "PowerBall ticket with SuperScam option  10.50",
          "TOTAL                                   22.63",
          "*** You saved:                           0.37"])
      end
    end
  end

  private

  def create_member
    post "/members", params: { name: "Ji Yang", phone: "719-287-4335", discount: "0.03" }
  end

  def create_checkout
    post "/checkouts", params: {}

    @checkout_id = json["id"]
  end

  def assign_member_to_checkout
    post "/checkouts/#{@checkout_id}/scan_member/719-287-4335"
  end

  def create_non_exempt_items
    post "/items/", params: { upc: "77332", description: "Pescanova Smelt Headless - 16oz", price: 7.78 }
    post "/items/", params: { upc: "84420", description: "Kellogs Bran Flakes Family Size 24oz", price: 4.72 }
  end

  def scan_non_exempt_items
    post "/checkouts/#{@checkout_id}/scan/84420"
    post "/checkouts/#{@checkout_id}/scan/77332"
  end
end
