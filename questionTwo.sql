-- Add two new columns to Customer table, namely num_invoices, and
-- num_prodcuts.
ALTER TABLE customer
ADD num_invoices int;
ADD num_products int;
-- Write SQL statements to update the values of the new columns
-- to reflect the data that was previously inserted in the database.

-- Add a new column to invoice table, namely invoice_total.
ALTER TABLE invoice
ADD invoice_total
 int;
--Write SQL statements to update the values of the new columns
--to reflect the data that was previously inserted in the database.

-- Create a trigger, trg_customer_invoice, that increments num_invoices
-- of the corresponding customer whenever a new invoice is added.
  CREATE TRIGGER 'inventorydb'.'trg_customer_invoice' AFTER INSERT ON 'invoice'
  FOR EACH ROW
  BEGIN
  UPDATE invoice SET num_invoices = num_invoices + 1 where inv_number = NEW.inv_number;
  END

  -- Create a trigger, trg_new_line, that is fired when a new row is inserted in
  -- line table. The trigger does the following two actions:
  -- a. increments num_products of the corresponding customer
  -- b. updates invoice_total of the corresponding invoice to include the
  -- cost of the added products
  CREATE TRIGGER 'inventorydb'.'trg_new_line' AFTER INSERT ON 'line'
  FOR EACH ROW
  BEGIN
  UPDATE customer SET num_products = num_products + 1 where invoice.cus_code prod_code = new.prod_code AND (SELECT from invoice where cus_code = invoice.cus_code) ;
  END

--   Create a stored procedure, prc_customer_discount, that takes two inputs,
-- customer code and discount amount. The procedure then applies the discount to
-- all invoices of the given customer by updating invoice_total values.
