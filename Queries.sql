CREATE TABLE "public.print_orders" (
	"id" serial NOT NULL,
	"photos_number" serial NOT NULL,
	"copies_number" bigint NOT NULL,
	"format" serial NOT NULL,
	"paper_type" serial NOT NULL,
	"cost" bigint NOT NULL,
	CONSTRAINT "print_orders_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.clients" (
	"id" serial NOT NULL,
	"first_name" TEXT NOT NULL,
	"last_name" TEXT NOT NULL,
	CONSTRAINT "clients_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.suppliers" (
	"id" serial NOT NULL,
	"firm_id" bigint NOT NULL,
	CONSTRAINT "suppliers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.photo_shops" (
	"id" serial NOT NULL,
	"type_id" char(1) NOT NULL,
	"address" TEXT NOT NULL,
	CONSTRAINT "photo_shops_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.supply_requests" (
	"id" serial NOT NULL,
	"supplier" bigint NOT NULL,
	"date" DATE NOT NULL,
	"number_of_products" bigint NOT NULL,
	CONSTRAINT "supply_requests_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.photo_shop_types" (
	"id" char(1) NOT NULL,
	"type_name" text NOT NULL,
	CONSTRAINT "photo_shop_types_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.offers" (
	"id" bigint NOT NULL,
	"offer_name" TEXT NOT NULL,
	"offer_type_id" bigint NOT NULL,
	"firm_id" bigint NOT NULL,
	"cost" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.orders" (
	"id" bigint NOT NULL,
	"print_order_id" bigint NOT NULL,
	"film_development_order_id" bigint NOT NULL,
	"done" bool NOT NULL,
	"urgency" bool NOT NULL,
	"client_id" bigint NOT NULL,
	"photo_shop_id" bigint NOT NULL,
	"date" DATE NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.purchases" (
	"id" serial NOT NULL,
	"client_id" bigint NOT NULL,
	"offer_id" bigint NOT NULL,
	"photo_shop_id" bigint NOT NULL,
	"date" DATE NOT NULL,
	CONSTRAINT "purchases_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.film_development_orders" (
	"id" serial NOT NULL,
	"cost" bigint NOT NULL,
	CONSTRAINT "film_development_orders_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.photo_shops_offers" (
	"photo_shop_id" bigint NOT NULL,
	"offer_id" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.firms" (
	"id" serial NOT NULL PRIMARY KEY,
	"firm_name" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.workplaces" (
	"id" serial NOT NULL,
	"workplace_name" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.photo_shops_workplaces" (
	"photo_shop_id" bigint NOT NULL,
	"workplace_id" bigint NOT NULL,
	"number" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.offer_types" (
	"id" serial NOT NULL PRIMARY KEY,
	"offer_type_name" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.product_types" (
	"id" serial NOT NULL,
	"product_type_name" TEXT NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.suppliers_products_types" (
	"product_type_id" bigint NOT NULL,
	"supplier_id" bigint NOT NULL
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.clients_photo_shops" (
	"client_id" bigint NOT NULL,
	"photoshop_id" bigint NOT NULL,
	"discount" bigint NOT NULL,
	"discount_card_number" bigint NOT NULL
) WITH (
  OIDS=FALSE
);


ALTER TABLE "public.product_types" ADD CONSTRAINT "product_types_pk" PRIMARY KEY ("id");


ALTER TABLE "public.suppliers" ADD CONSTRAINT "suppliers_fk0" FOREIGN KEY ("firm_id") REFERENCES "public.firms"("id");

ALTER TABLE "public.photo_shops" ADD CONSTRAINT "photo_shops_fk0" FOREIGN KEY ("type") REFERENCES "public.photo_shop_types"("id");

ALTER TABLE "public.supply_requests" ADD CONSTRAINT "supply_requests_fk0" FOREIGN KEY ("supplier") REFERENCES "public.suppliers"("id");


ALTER TABLE "public.offers" ADD CONSTRAINT "offers_pk" PRIMARY KEY ("id");

ALTER TABLE "public.offers" ADD CONSTRAINT "offers_fk0" FOREIGN KEY ("offer_type_id") REFERENCES "public.offer_types"("id");
ALTER TABLE "public.offers" ADD CONSTRAINT "offers_fk1" FOREIGN KEY ("firm_id") REFERENCES "public.firms"("id");

ALTER TABLE "public.orders" ADD CONSTRAINT "orders_fk0" FOREIGN KEY ("print_order_id") REFERENCES "public.print_orders"("id");
ALTER TABLE "public.orders" ADD CONSTRAINT "orders_fk1" FOREIGN KEY ("film_development_order_id") REFERENCES "public.film_development_orders"("id");
ALTER TABLE "public.orders" ADD CONSTRAINT "orders_fk2" FOREIGN KEY ("client_id") REFERENCES "public.clients"("id");
ALTER TABLE "public.orders" ADD CONSTRAINT "orders_fk3" FOREIGN KEY ("photo_shop_id") REFERENCES "public.photo_shops"("id");

ALTER TABLE "public.purchases" ADD CONSTRAINT "purchases_fk0" FOREIGN KEY ("client_id") REFERENCES "public.clients"("id");
ALTER TABLE "public.purchases" ADD CONSTRAINT "purchases_fk1" FOREIGN KEY ("offer_id") REFERENCES "public.offers"("id");
ALTER TABLE "public.purchases" ADD CONSTRAINT "purchases_fk2" FOREIGN KEY ("photo_shop_id") REFERENCES "public.photo_shops"("id");


ALTER TABLE "public.photo_shops_offers" ADD CONSTRAINT "photo_shops_offers_fk0" FOREIGN KEY ("photo_shop_id") REFERENCES "public.photo_shops"("id");
ALTER TABLE "public.photo_shops_offers" ADD CONSTRAINT "photo_shops_offers_fk1" FOREIGN KEY ("offer_id") REFERENCES "public.offers"("id");

ALTER TABLE "public.workplaces" ADD CONSTRAINT "workplaces_pk" PRIMARY KEY ("id");


ALTER TABLE "public.photo_shops_workplaces" ADD CONSTRAINT "photo_shops_workplaces_fk0" FOREIGN KEY ("photo_shop_id") REFERENCES "public.photo_shops"("id");
ALTER TABLE "public.photo_shops_workplaces" ADD CONSTRAINT "photo_shops_workplaces_fk1" FOREIGN KEY ("workplace_id") REFERENCES "public.workplaces"("id");

ALTER TABLE "public.product_types" ADD CONSTRAINT "product_types_pk" PRIMARY KEY ("id");

ALTER TABLE "public.suppliers_products_types" ADD CONSTRAINT "suppliers_products_types_fk0" FOREIGN KEY ("product_type_id") REFERENCES "public.product_types"("id");
ALTER TABLE "public.suppliers_products_types" ADD CONSTRAINT "suppliers_products_types_fk1" FOREIGN KEY ("supplier_id") REFERENCES "public.suppliers"("id");

ALTER TABLE "public.clients_photo_shops" ADD CONSTRAINT "clients_photo_shops_fk0" FOREIGN KEY ("client_id") REFERENCES "public.clients"("id");
ALTER TABLE "public.clients_photo_shops" ADD CONSTRAINT "clients_photo_shops_fk1" FOREIGN KEY ("photoshop_id") REFERENCES "public.photo_shops"("id");



INSERT INTO "public.photo_shop_types" (id, type_name) VALUES
	(1, 'shop'),
	(2, 'kiosk');

INSERT INTO "public"."photo_shops" (type_id, address) VALUES
	(1, 'Терешковой, 12'),
	(2, 'Ильича, 6a'),
	(1, 'Ленина, 27'),
	(2, 'Пролетарская, 3'),
	(3, 'Советская, 10');



INSERT INTO "public.clients" (first_name, last_name) VALUES
	('John', 'Smith'),
	('Abrik', 'Valishev'),
	('Tony', 'Stark');

INSERT INTO "public.clients" (first_name, last_name) VALUES
	('Alice', 'Johnson'),
	('Bob', 'Williams'),
	('Carla', 'Garcia');



INSERT INTO "public.workplaces" (workplace_name) VALUES
	('Кассир'),
	('Грузчик'),
	('Администратор'),
	('Фотограф');

INSERT INTO "public.workplaces" (workplace_name) VALUES
	('Менеджер по продажам'),
	('Дизайнер'),
	('Оператор сканирования'),
	('Ретушер');


INSERT INTO "public.firms" (firm_name) VALUES
	('Canon'),
	('Nikon'),
	('Polaroid'),
	('Sony');

INSERT INTO public.firms (firm_name) VALUES
	('Fujifilm'),
	('Leica'),
	('Panasonic'),
	('Olympus');


INSERT INTO "public.offer_types" (offer_type_name) VALUES
	('Товар'),
	('Услуга');

INSERT INTO "public.offers" (offer_name, offer_type_id, firm_id, cost) VALUES
	('Камера', 1, 1, 10000),
	('Камера', 1, 4, 15000),
	('Фото на документы', 2, NULL, 400);

INSERT INTO "public.clients_photo_shops" (client_id, photoshop_id, discount, discount_card_number) VALUES
	(1, 2, NULL, NULL),
	(2, 1, 10, 0);

INSERT INTO "public.photo_shops_offers" (photo_shop_id, offer_id) VALUES
	(1, 4),
	(1, 5),
	(1, 6),
	(2, 4),
	(2, 5);

INSERT INTO "public.photo_shops_workplaces" (photo_shop_id, workplace_id, number) VALUES
	(1, 1, 2),
	(1, 2, 2),
	(1, 1, 3),
	(1, 1, 4),
	(2, 1, 1);

INSERT INTO "public.print_orders" (photos_number, copies_number, format, paper_type, cost) VALUES
	(1, 1, 'A4', 'glossy', 100),
	(5, 1, 'A5', 'lusster', 400);

INSERT INTO "public.orders" (print_order_id, film_development_order_id, done, urgency, client_id, photo_shop_id, date) VALUES
	(1, 2, false, false, 1, 2, '2023-04-11'),
	(2, NULL, true, false, 2, 1, '2023-04-08');

INSERT INTO "public.suppliers" (name) VALUES
	('Канон'),
	('ФотоТовары');

INSERT INTO "public.product_types" (product_type_name) VALUES
	('Объектив'),
	('Фото-бумага'),
	('Фото-пленка');

INSERT INTO "public.suppliers_products_types" (product_type_id, supplier_id, firm_id) VALUES
	(1, 1, 1),
	(1, 2, 1),
	(2, 1, 2),
	(2, 1, 3),
	(3, 1, 2);

INSERT INTO "public.supply_requests" (supplier_product_type_id, date, number_of_products) VALUES
	(1, '2023-03-01', 100),
	(2, '2023-03-01', 100),
	(2, '2023-03-05', 200),
	(1, '2023-03-05', 150);



-- 1

SELECT address
FROM "public.photo_shops"

SELECT count(address)
FROM "public.photo_shops"

SELECT address
FROM "public.photo_shops" AS P
	JOIN "public.photo_shop_types" AS T
	ON P.type_id = T.id
WHERE type_name = 'shop'

SELECT count(address)
FROM "public.photo_shops" AS P
	JOIN "public.photo_shop_types" AS T
	ON P.type_id = T.id
WHERE type_name = 'shop'

SELECT address
FROM "public.photo_shops" AS P
	JOIN "public.photo_shop_types" AS T
	ON P.type_id = T.id
WHERE type_name = 'kiosk'

SELECT count(address)
FROM "public.photo_shops" AS P
	JOIN "public.photo_shop_types" AS T
	ON P.type_id = T.id
WHERE type_name = 'kiosk'


-- 2

SELECT *
FROM "public.orders"
WHERE date > '2023-04-10'
	AND date < '2023-04-12'

SELECT count(id)
FROM "public.orders"
WHERE date > '2023-04-10'
	AND date < '2023-04-12'

SELECT O.id
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.photo_shop_types" AS T
		ON PS.type_id = T.id
WHERE date > '2023-04-10'
	AND date < '2023-04-12'
	AND	type_name = 'shop'

SELECT count(O.id)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.photo_shop_types" AS T
		ON PS.type_id = T.id
WHERE date > '2023-04-10'
	AND date < '2023-04-12'
	AND	type_name = 'shop'

SELECT O.id
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.photo_shop_types" AS T
		ON PS.type_id = T.id
WHERE date > '2023-04-10'
	AND date < '2023-04-12'
	AND	type_name = 'kiosk'

SELECT count(O.id)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.photo_shop_types" AS T
		ON PS.type_id = T.id
WHERE date > '2023-04-10'
	AND date < '2023-04-12'
	AND	type_name = 'kiosk'


-- 3

SELECT O.id
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
WHERE date > '2023-04-07'
	AND date < '2023-04-10'
	AND urgency = false
	AND PS.address = 'Терешковой, 12'

SELECT count(O.id)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
WHERE date > '2023-04-07'
	AND date < '2023-04-10'
	AND urgency = false
	AND PS.address = 'Терешковой, 12'

SELECT O.id
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
WHERE date > '2023-04-07'
	AND date < '2023-04-10'
	AND urgency = true
	AND PS.address = 'Терешковой, 12'

SELECT count(O.id)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
WHERE date > '2023-04-07'
	AND date < '2023-04-10'
	AND urgency = true
	AND PS.address = 'Терешковой, 12'


-- 4

SELECT urgency, SUM(cost)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.print_orders" AS PO
		ON O.print_order_id = PO.id
WHERE date > '2023-04-07'
	AND date < '2023-04-10'
	AND PS.address = 'Терешковой, 12'
GROUP BY urgency


-- 5

SELECT urgency, SUM(photos_number * copies_number)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.print_orders" AS PO
		ON O.print_order_id = PO.id
WHERE date > '2023-04-07'
	AND date < '2023-04-10'
	AND done = true
	AND PS.address = 'Терешковой, 12'
GROUP BY urgency

SELECT urgency, SUM(photos_number * copies_number)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.print_orders" AS PO
		ON O.print_order_id = PO.id
WHERE date > '2023-04-07'
	AND date < '2023-04-12'
	AND done = true
GROUP BY urgency


-- 6

SELECT urgency, SUM(FDO.id)
FROM "public.orders" AS O
	JOIN "public.photo_shops" AS PS
		ON O.photo_shop_id = PS.id
	JOIN "public.film_development_orders" AS FDO
		ON O.film_development_order_id = FDO.id
WHERE date > '2023-04-07'
	AND date < '2023-04-12'
	AND done = true
	AND PS.address = 'Терешковой, 12'
GROUP BY urgency


-- 7

SELECT S.id, S.name
FROM "public.suppliers" AS S
	JOIN "public.suppliers_products_types" AS SPT
		ON S.id = SPT.supplier_id
	JOIN "public.supply_requests" AS SR
		ON SPT.id = SR.supplier_product_type_id
WHERE date > '2023-02-25'
	AND date < '2023-03-05'

SELECT S.name, PT.product_type_name
FROM "public.suppliers" AS S
	JOIN "public.suppliers_products_types" AS SPT
		ON S.id = SPT.supplier_id
	JOIN "public.supply_requests" AS SR
		ON SPT.id = SR.supplier_product_type_id
	JOIN "public.product_types" AS PT
		ON PT.id = SPT.product_type_id
WHERE date > '2023-02-25'
	AND date < '2023-03-05'

SELECT S.name, PT.product_type_name, SUM(number_of_products) sum_num_of_products
FROM "public.suppliers" AS S
	JOIN "public.suppliers_products_types" AS SPT
		ON S.id = SPT.supplier_id
	JOIN "public.supply_requests" AS SR
		ON SPT.id = SR.supplier_product_type_id
	JOIN "public.product_types" AS PT
		ON PT.id = SPT.product_type_id
GROUP BY 
	S.name, 
	PT.product_type_name
HAVING SUM(number_of_products) > 250


-- 8

SELECT *
FROM "public.clients"

SELECT 
	C.id, 
	C.first_name, 
	C.last_name
FROM "public.clients" AS C
	JOIN "public.clients_photo_shops" AS CPS
		ON C.id = CPS.client_id
	JOIN "public.photo_shops" AS PS
		ON PS.id = CPS.photoshop_id
WHERE 
	PS.address = 'Терешковой, 12'
	AND CPS.discount > 0


SELECT 
	C.id, 
	C.first_name, 
	C.last_name
FROM "public.clients" AS C
	JOIN "public.orders" AS O
		ON O.client_id = C.id
	JOIN "public.photo_shops" AS PS
		ON PS.id = O.photo_shop_id
	JOIN "public.clients_photo_shops" AS CPS
		ON PS.id = CPS.photoshop_id
	JOIN "public.print_orders" PO
		ON PO.id = O.print_order_id
WHERE 
	CPS.client_id = C.id
	AND PS.address = 'Терешковой, 12'
	AND CPS.discount > 0
	AND PO.photos_number * PO.copies_number > 1


-- 9

SELECT
	SUM(O.cost)
FROM "public.purchases" AS P
	JOIN "public.photo_shops" AS PS
		ON P.photo_shop_id = PS.id
	JOIN "public.offers" AS O
		ON O.id = P.offer_id
	JOIN "public.offer_types" AS OT
		ON OT.id = O.offer_type_id
WHERE OT.OFFER_TYPE_NAME = 'Товар'

SELECT
	SUM(O.cost)
FROM "public.purchases" AS P
	JOIN "public.photo_shops" AS PS
		ON P.photo_shop_id = PS.id
	JOIN "public.offers" AS O
		ON O.id = P.offer_id
	JOIN "public.offer_types" AS OT
		ON OT.id = O.offer_type_id
WHERE OT.OFFER_TYPE_NAME = 'Товар'
	AND PS.address = 'Терешковой, 12'
	AND P.date > '2023-03-29'
	AND P.date <= '2023-04-12'


-- 10
	
WITH PRODUCTS_COUNT AS (
	SELECT
		O.offer_name,
		F.firm_name,
		COUNT(P.id) count_of_product
	FROM "public.purchases" AS P
		JOIN "public.photo_shops" AS PS
			ON P.photo_shop_id = PS.id
		JOIN "public.offers" AS O
			ON O.id = P.offer_id
		JOIN "public.offer_types" AS OT
			ON OT.id = O.offer_type_id
			JOIN "public.firms" AS F
			ON F.id = O.firm_id
	WHERE OT.OFFER_TYPE_NAME = 'Товар'
	GROUP BY
		O.offer_name,
		F.firm_name
)

SELECT 
	O.offer_name,
	F.firm_name
FROM "public.purchases" AS P
	JOIN "public.photo_shops" AS PS
		ON P.photo_shop_id = PS.id
	JOIN "public.offers" AS O
		ON O.id = P.offer_id
	JOIN "public.offer_types" AS OT
		ON OT.id = O.offer_type_id
	JOIN "public.firms" AS F
		ON F.id = O.firm_id,
	PRODUCTS_COUNT
WHERE OT.OFFER_TYPE_NAME = 'Товар'
GROUP BY
	O.offer_name,
	F.firm_name,
	PRODUCTS_COUNT.count_of_product
HAVING PRODUCTS_COUNT.count_of_product = MAX(P.id)


-- 11

SELECT 
	O.offer_name,
	F.firm_name,
	COUNT(P.id) count_of_product
FROM "public.purchases" AS P
	JOIN "public.photo_shops" AS PS
		ON P.photo_shop_id = PS.id
	JOIN "public.offers" AS O
		ON O.id = P.offer_id
	JOIN "public.offer_types" AS OT
		ON OT.id = O.offer_type_id
	JOIN "public.firms" AS F
		ON F.id = O.firm_id
WHERE OT.OFFER_TYPE_NAME = 'Товар'
	AND P.date > '2023-03-29'
	AND P.date <= '2023-04-12'
	AND PS.address = 'Терешковой, 12'
GROUP BY
	O.offer_name,
	F.firm_name


-- 12

SELECT DISTINCT
	PS.address,
	W.workplace_name,
	PSW.number
FROM "public.workplaces" AS W
	JOIN "public.photo_shops_workplaces" AS PSW
		ON W.id = PSW.photo_shop_id
	JOIN "public.photo_shops" AS PS
		ON PS.id = PSW.photo_shop_id

SELECT DISTINCT
	PS.address,
	W.workplace_name,
	PSW.number
FROM "public.workplaces" AS W
	JOIN "public.photo_shops_workplaces" AS PSW
		ON W.id = PSW.photo_shop_id
	JOIN "public.photo_shops" AS PS
		ON PS.id = PSW.photo_shop_id
WHERE W.workplace_name = 'Кассир'


CREATE OR REPLACE FUNCTION check_discount_range()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.discount >= 0 AND NEW.discount <= 100 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'discount must be greater than 0 and less than or equal to 100';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER discount_clients_photo_shops
BEFORE UPDATE ON "public.clients_photo_shops"
FOR EACH ROW
EXECUTE FUNCTION check_discount_range();


CREATE OR REPLACE FUNCTION check_film_development_orders_cost()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cost >= 0 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Cost must be greater than or equal to 0';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER film_development_orders_cost_check
BEFORE INSERT OR UPDATE ON "public.film_development_orders"
FOR EACH ROW
EXECUTE FUNCTION check_film_development_orders_cost();


CREATE OR REPLACE FUNCTION check_print_orders_cost()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cost >= 0 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Cost must be greater than or equal to 0';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER print_orders_cost_check
BEFORE INSERT OR UPDATE ON "public.print_orders"
FOR EACH ROW
EXECUTE FUNCTION check_print_orders_cost();


CREATE OR REPLACE FUNCTION check_offers_cost()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cost >= 0 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Cost must be greater than or equal to 0';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER offers_cost_check
BEFORE INSERT OR UPDATE ON "public.offers"
FOR EACH ROW
EXECUTE FUNCTION check_offers_cost();


CREATE OR REPLACE FUNCTION check_photo_shops_workplaces_number()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.number > 0 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Number must be greater than 0';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER photo_shops_workplaces_number_check
BEFORE INSERT OR UPDATE ON "public.photo_shops_workplaces"
FOR EACH ROW
EXECUTE FUNCTION check_photo_shops_workplaces_number();


CREATE OR REPLACE FUNCTION check_supply_requests_number_of_products()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.number_of_products > 0 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Number of products must be greater than 0';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER supply_requests_number_of_products_check
BEFORE INSERT OR UPDATE ON "public.supply_requests"
FOR EACH ROW
EXECUTE FUNCTION check_supply_requests_number_of_products();



CREATE OR REPLACE FUNCTION check_print_orders_numbers()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.photos_number > 0 AND NEW.copies_number > 0 THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Photos number and copies number must be greater than 0';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER print_orders_numbers_check
BEFORE INSERT OR UPDATE ON "public.print_orders"
FOR EACH ROW
EXECUTE FUNCTION check_print_orders_numbers();


CREATE OR REPLACE FUNCTION check_clients_photo_shops_discount_card_number()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM public.clients_photo_shops
        WHERE discount_card_number = NEW.discount_card_number
    ) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Discount card number already exists';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER clients_photo_shops_discount_card_number_check
BEFORE INSERT OR UPDATE ON "public.clients_photo_shops"
FOR EACH ROW
EXECUTE FUNCTION check_clients_photo_shops_discount_card_number();


CREATE OR REPLACE FUNCTION check_orders_print_or_film_id_not_null()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.print_order_id IS NOT NULL OR NEW.film_development_id IS NOT NULL THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Print order ID or film development ID must not be null';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "orders_print_or_film_id_check"
BEFORE INSERT OR UPDATE ON "public.orders"
FOR EACH ROW
EXECUTE FUNCTION check_orders_print_or_film_id_not_null();


CREATE OR REPLACE FUNCTION convert_firm_name_to_uppercase()
RETURNS TRIGGER AS $$
BEGIN
    NEW.firm_name := UPPER(NEW.firm_name);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "convert_firm_name_to_uppercase_trigger"
BEFORE INSERT OR UPDATE ON "public.firms"
FOR EACH ROW
EXECUTE FUNCTION convert_firm_name_to_uppercase();



CREATE OR REPLACE FUNCTION check_discount_when_card_number_not_null()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.discount_card_number IS NOT NULL AND NEW.discount IS NULL THEN
        RAISE EXCEPTION 'Discount cannot be null when discount card number is not null.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "check_discount_card_number_not_null_trigger"
BEFORE INSERT OR UPDATE ON "public.clients_photo_shops"
FOR EACH ROW
EXECUTE FUNCTION check_discount_when_card_number_not_null();


CREATE OR REPLACE FUNCTION check_date_not_greater_than_now()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.date > NOW() THEN
        RAISE EXCEPTION 'Date cannot be in the future.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "check_date_not_greater_than_now_trigger"
BEFORE INSERT OR UPDATE ON "public.orders"
FOR EACH ROW
EXECUTE FUNCTION check_date_not_greater_than_now();


CREATE OR REPLACE FUNCTION check_date_not_greater_than_now()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.date > NOW() THEN
        RAISE EXCEPTION 'Date cannot be in the future.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER "check_date_not_greater_than_now_trigger"
BEFORE INSERT OR UPDATE ON "public.offers"
FOR EACH ROW
EXECUTE FUNCTION check_date_not_greater_than_now();
