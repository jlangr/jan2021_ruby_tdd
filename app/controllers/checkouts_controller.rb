class CheckoutsController < ApplicationController
  before_action :set_checkout, only: [:show, :scan, :checkout_total, :scan_member]
  LINE_WIDTH = 45

  # solve with serializers?
  def show
    items = CheckoutItem.where(checkout_id: @checkout.id)
    items_hash = items.map { |item| item.serializable_hash }
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

  def retrieve_items
    @checkout.checkout_items.map { |checkout_item| Item.find_by(upc: checkout_item.upc) }
  end

  def checkout_total
    items = retrieve_items

    total_saved = calculate_total_saved(items)
    total_of_all_items = calculate_total_of_all_items
    total_of_discounted_items = calculate_total_of_discounted_items

    messages = receipt(total_of_all_items, total_saved)

    json_response({
                    checkout_id: @checkout.id,
                    messages: messages,
                    total: format_dollar_amount(total_of_all_items),
                    total_of_discounted_items: format_dollar_amount(total_of_discounted_items),
                    total_saved: format_dollar_amount(total_saved)})
  end

  private

  def receipt(total_of_all_items, total_saved)
    messages = []

    @checkout.checkout_items.each do |checkout_item|
      item = Item.find_by(upc: checkout_item.upc)
      messages << formatted_line_item(item.description, item.price)
      if discountable?(item)
        messages << formatted_line_item(discount_line_item_text(member_discount_for_checkout), -(member_discount_for_checkout * item.price))
      end
    end

    messages << formatted_line_item("TOTAL", total_of_all_items)
    if total_saved > 0
      messages << formatted_line_item("*** You saved:", total_saved)
    end
    messages
  end

  def calculate_total_saved(items)
    items.filter { | item | discountable? item }
         .inject(0) { | total, item | total + member_discount_for_checkout * item.price }
  end

  def calculate_total_of_discounted_items
    total_of_discounted_items = 0
    @checkout.checkout_items.each do |checkout_item|
      item = Item.find_by(upc: checkout_item.upc)
      if discountable?(item)
        total_of_discounted_items += item.price * (1.0 - member_discount_for_checkout)
      end
    end
    total_of_discounted_items
  end

  def calculate_total_of_all_items
    total_of_all_items = 0

    @checkout.checkout_items.each do |checkout_item|
      item = Item.find_by(upc: checkout_item.upc)
      if discountable?(item)
        total_of_all_items += item.price * (1.0 - member_discount_for_checkout)
      else
        total_of_all_items += item.price
      end
    end
    total_of_all_items
  end

  def member_discount_for_checkout
    @checkout.member_name ? @checkout.member_discount : 0
  end

  def discountable?(item)
    not (item.is_exempt or member_discount_for_checkout === 0)
  end

  def discount_line_item_text(discount)
    discount_percent = "#{discount * 100}%"
    "   #{discount_percent} mbr disc"
  end

  def formatted_line_item(description_text, dollar_amount)
    formatted_total = format_dollar_amount(dollar_amount)
    description_text.ljust(LINE_WIDTH - formatted_total.length) + formatted_total
  end

  def format_dollar_amount(dollar_amount)
    sprintf("%.2f", dollar_amount.round(2))
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
