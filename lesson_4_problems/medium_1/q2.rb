class InvoiceEntry
  attr_reader :quantity, :product_name
  attr_writer :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end

=begin
- Alyssa looked at the code and spotted a mistake. "This will fail when 
  update_quantity is called", she says.

- Can you spot the mistake and how to address it?
=end

p invoice = InvoiceEntry.new("Toy", 100)
invoice.update_quantity(150)
p invoice