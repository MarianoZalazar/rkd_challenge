-- This script is already implemented inside the initialization script, so there's no need to run this in terminal

CREATE OR REPLACE FUNCTION insert_fnc() RETURNS TRIGGER AS 
 ' 
    BEGIN
       INSERT INTO itemregister(item_id, seller_id, name, price_per_unit, description, active, at_date) 
       VALUES (NEW.item_id, NEW.seller_id, NEW.name, NEW.price_per_unit, NEW.description, NEW.active, CURRENT_DATE);
       RETURN NULL;
    END;
 ' LANGUAGE plpgsql;

 CREATE TRIGGER insert_items
 AFTER INSERT ON items
 FOR EACH ROW EXECUTE PROCEDURE insert_fnc();

 CREATE OR REPLACE FUNCTION update_func() RETURNS TRIGGER AS 
 ' 
    BEGIN
       UPDATE itemregister
       SET name = NEW.name,
           price_per_unit = NEW.price_per_unit,
           description = NEW.description,
           active = NEW.active,
           at_date = CURRENT_DATE;
       RETURN NULL;
    END;
 ' LANGUAGE plpgsql;

 CREATE TRIGGER update_items
 AFTER UPDATE ON items
 FOR EACH ROW EXECUTE PROCEDURE update_func();
