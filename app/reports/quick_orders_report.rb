class QuickOrdersReport < BaseReport
  def call
    result[:users] = []
    orders = QuickOrder.includes(:user).done.where(created_at: period).in_department(department)

    if orders.any?
      orders.order('count_quick_orders_id desc').group(:user_id).count('quick_orders.id').each_pair do |user_id, qty|
        user = User.find(user_id)
        result[:users] << {name: user.short_name, qty: qty}
      end
      result[:total_qty] = orders.count
    else
      result[:total_qty] = 0
    end
    result
  end
end
