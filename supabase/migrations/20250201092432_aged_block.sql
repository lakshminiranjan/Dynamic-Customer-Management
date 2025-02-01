/*
  # Update customer table for measurements

  1. Changes
    - Remove `email` and `address` columns
    - Add `shirt` and `pants` columns for measurements
    
  2. Notes
    - Using safe column addition with IF NOT EXISTS checks
    - Preserving existing data by adding nullable columns first
*/

-- Add new columns
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'customers' AND column_name = 'shirt'
  ) THEN
    ALTER TABLE customers ADD COLUMN shirt text;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'customers' AND column_name = 'pants'
  ) THEN
    ALTER TABLE customers ADD COLUMN pants text;
  END IF;
END $$;

-- Make new columns required after they're added
ALTER TABLE customers ALTER COLUMN shirt SET NOT NULL;
ALTER TABLE customers ALTER COLUMN pants SET NOT NULL;

-- Drop old columns if they exist
DO $$ 
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'customers' AND column_name = 'email'
  ) THEN
    ALTER TABLE customers DROP COLUMN email;
  END IF;

  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'customers' AND column_name = 'address'
  ) THEN
    ALTER TABLE customers DROP COLUMN address;
  END IF;
END $$;