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
      if discountable?(item)
        total_of_discounted_items += discounted_price(price) # add into total

        text = item.description
        # format percent
        amount = formatted_currency(price)
        messages << formatted_message(amount, text)

        total += discounted_price(price)

        # discount line
        discount_formatted = '-' + formatted_currency(discount_amount(price))
        text = "   #{member_discount * 100}% mbr disc"
        messages << formatted_message(discount_formatted, text)

        total_saved += discount_amount(price)
      else
        total += price
        text = item.description
        amount = formatted_currency(price)
        messages << formatted_message(amount, text)
      end
    end

    # append total line
    formatted_total = formatted_currency(total)
    text = "#{formatted_message(formatted_total, 'TOTAL')}"
    messages << text

    if total_saved > 0
      formatted_total_saved = formatted_currency(total_saved)
      text = "#{formatted_message(formatted_total_saved, '*** You saved:')}"
      messages << text
    end

    total_of_discounted_items = formatted_currency(total_of_discounted_items)
    total_saved = formatted_currency(total_saved)

    # send total saved instead
    json_response({checkout_id: @checkout.id, total: formatted_total, total_of_discounted_items: total_of_discounted_items, messages: messages, total_saved: formatted_total_saved})
  end

  private

  def discount_amount(price)
    (member_discount * price).round(2)
  end

  def discounted_price(price)
    price * (1.0 - member_discount)
  end

  def discountable?(item)
    !(item.is_exempt && member_discount > 0)
  end

  def member_discount
    @checkout.member_discount || 0
  end

  def formatted_currency(amount)
    sprintf("%.2f", amount.round(2))
  end

  def formatted_message(value, text)
    value_width = value.length

    text_width = LINE_WIDTH - value_width
    text.ljust(text_width) + value
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
