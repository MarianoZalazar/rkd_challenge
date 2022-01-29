-- This script is already implemented inside the initialization script, so there's no need to run this in terminal

CREATE OR REPLACE FUNCTION insert_fnc() RETURNS TRIGGER AS 
$$ 
   BEGIN
      INSERT INTO itemregister(item_id, seller_id, name, price_per_unit, description, active, at_date) 
      VALUES (NEW.item_id, NEW.seller_id, NEW.name, NEW.price_per_unit, NEW.description, NEW.active, (CURRENT_DATE));
      RETURN NULL;
   END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_items
AFTER INSERT ON items
FOR EACH ROW EXECUTE PROCEDURE insert_fnc();

CREATE OR REPLACE FUNCTION update_func() RETURNS TRIGGER AS 
$$ 
BEGIN
   UPDATE itemregister
   SET price_per_unit = NEW.price_per_unit,
      active = NEW.active,
      at_date = CURRENT_DATE
   WHERE item_id = NEW.item_id;
   RETURN NEW;
   END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_items
AFTER UPDATE ON items
FOR EACH ROW EXECUTE PROCEDURE update_func();

CREATE OR REPLACE FUNCTION update_register() RETURNS TRIGGER AS 
$$
   BEGIN
   IF OLD.at_date <> NEW.at_date THEN
   INSERT INTO itemregister(item_id, seller_id, name, price_per_unit, description, active, at_date) 
   VALUES (NEW.item_id, NEW.seller_id, NEW.name, NEW.price_per_unit, NEW.description, NEW.active, CURRENT_DATE);
   RETURN NULL;
   ELSE
   RETURN NEW;
   END IF;
   END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_register_items
BEFORE UPDATE ON itemregister
FOR EACH ROW EXECUTE PROCEDURE update_register();