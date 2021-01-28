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

  def checkout_total
    messages = []

    total_of_discounted_items = 0
    total = 0
    total_saved = 0

    @checkout.checkout_items.each do | checkout_item |
      item = Item.find_by(upc: checkout_item.upc)
      price = item.price
      description = item.description
      amount = format_percent(price)
      amount_width = amount_width(amount)

      messages << description.ljust(amount_width) + amount
      if eligible_for_discount?(item)
        total_of_discounted_items += discounted_price(price)

        price = discounted_price(price)
        total_saved += discount_amount(price).round(2)

        messages << discount_line(discount_amount(price), discount)
      end
      total += price
    end

    messages << append_total_line(total)

    if total_saved > 0
      formatted_total_saved = format_percent(total_saved)
      messages << append_total_saved(total_saved)
    end

    total_of_discounted_items = format_percent(total_of_discounted_items)
    total_saved = format_percent(total_saved)

    # send total saved instead
    json_response(checkout_id: @checkout.id, 
                  total: format_percent(total), 
                  total_of_discounted_items: total_of_discounted_items, 
                  messages: messages, 
                  total_saved: formatted_total_saved)
  end

  private

  def discounted_price(price)
    price * (1.0 - discount)
  end

  def discount_amount(price)
    discount * price
  end

  def discount
    @checkout.member_name ? @checkout.member_discount : 0
  end

  def eligible_for_discount?(item)
    not item.is_exempt and discount > 0
  end

  def amount_width(amount)
    amount_width = amount.length
    LINE_WIDTH - amount_width
  end

  def format_percent(number)
    sprintf("%.2f", number.round(2))
  end

  def append_total_saved(total_saved)
    formatted_total_saved = format_percent(total_saved)
    formatted_total_saved_width = formatted_total_saved.length
    text_width = LINE_WIDTH - formatted_total_saved_width
    "*** You saved:".ljust(text_width) + formatted_total_saved
  end

  def discount_line(discount_amount, discount)
    discount_formatted = '-' + format_percent(discount_amount)
    text_width = LINE_WIDTH - discount_formatted.length
    text = "   #{discount * 100}% mbr disc"
    "#{text.ljust(text_width)}#{discount_formatted}"
  end

  def append_total_line(total)
    formatted_total = format_percent(total)
    formatted_total_width = formatted_total.length
    text_width = LINE_WIDTH - formatted_total_width
    "TOTAL".ljust(text_width) + formatted_total
  end


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
