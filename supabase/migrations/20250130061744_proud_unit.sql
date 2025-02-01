/*
  # Fix RLS policies for customers table
  
  1. Changes
    - Remove authenticated requirement from policies
    - Allow public access for all operations
    - Keep basic structure intact
  
  Note: Since this is a demo application, we're allowing public access. In a production environment, 
  you would want to implement proper authentication.
*/

-- Drop existing policies
DROP POLICY IF EXISTS "Users can read customers" ON customers;
DROP POLICY IF EXISTS "Users can insert customers" ON customers;
DROP POLICY IF EXISTS "Users can update customers" ON customers;
DROP POLICY IF EXISTS "Users can delete customers" ON customers;

-- Create new public access policies
CREATE POLICY "Allow public read customers"
  ON customers
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public insert customers"
  ON customers
  FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Allow public update customers"
  ON customers
  FOR UPDATE
  TO public
  USING (true);

CREATE POLICY "Allow public delete customers"
  ON customers
  FOR DELETE
  TO public
  USING (true);