class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show, :scan, :checkout_total, :scan_member]
  LINE_WIDTH=45

  # solve with serializers?
  def show
    items = CheckoutItem.where(checkout_id: @checkout.id)
    items_hash = items.map {| item | item.serializable_hash }
    with_items = @checkout.serializable_hash.merge({ items: items_hash })
     json_response(with_items)
  end

  def create
    @checkout = Checkout.create!(checkout_params)
    json_response({ id: @checkout.id }, :created)
  end

  def scan
    upc = params[:upc]
    add_checkout_item(upc)
    json_response(scan_response_with_item_details(upc))
  end

  def scan_member
    member = Member.find_by(phone: params[:member_phone])
    return json_response({}, :not_found) unless member
    add_member_to_checkout(member)
  end

  def charge
    params.permit(:id, :name, :card, :exp, :amount)
    puts "credit verify #{params}"
  end

  def format_percent(price, text)
    amount = sprintf("%.2f", price.round(2))
    amount_width = amount.length

    text_width = LINE_WIDTH - amount_width
    text.ljust(text_width) + amount
  end

  def checkout_total
    messages = []
    discount = @checkout.member_name ? @checkout.member_discount : 0

    total_of_discounted_items = 0
    total = 0
    total_saved = 0

    @checkout.checkout_items.each do | checkout_item |
      item = Item.find_by(upc: checkout_item.upc)
      price = item.price
      is_exempt = item.is_exempt
      if not is_exempt and discount > 0
        discount_amount = discount * price
        discounted_price = price * (1.0 - discount)

        total_of_discounted_items += discounted_price # add into total

        text = item.description
        messages << format_percent(price, text)

        total += discounted_price

        text = "   #{discount * 100}% mbr disc"
        messages << format_percent(-discount_amount, text)

        total_saved += discount_amount.round(2)
      else
        total += price
        messages << format_percent(price, item.description)
      end
    end

    # append total line
    formatted_total = sprintf("%.2f", total.round(2))
    messages << format_percent(total, 'TOTAL')

    if total_saved > 0
      formatted_total_saved = sprintf("%.2f", total_saved.round(2))
      messages << format_percent(total_saved, "*** You saved:")
    end

    total_of_discounted_items = sprintf("%.2f", total_of_discounted_items.round(2))
    total_saved = sprintf("%.2f", total_saved.round(2))

    # send total saved instead
    json_response({checkout_id: @checkout.id, total: formatted_total, total_of_discounted_items: total_of_discounted_items, messages: messages, total_saved: formatted_total_saved})
  end

  private

  def scan_response_with_item_details(upc)
    item = Item.find_by(upc: upc)
    { upc: upc, description: item.description, price: item.price, is_exempt: item.is_exempt }
  end

  def add_checkout_item(upc)
    checkout_item = CheckoutItem.new(:upc => upc)
    @checkout.checkout_items << checkout_item
    checkout_item.save!
    @checkout.save!
  end

  def checkout_params
    params.permit()
  end

  def set_checkout
#    @checkout = Checkout.find(params[:id])
    @checkout = Checkout.includes(:checkout_items).find(params[:id])
  end

  def add_member_to_checkout(member)
    @checkout.member_name = member.name
    @checkout.member_discount = member.discount
    @checkout.save!
  end
end
