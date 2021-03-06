
--
-- Create model ContentType
--
CREATE TABLE "DJANGO_CONTENT_TYPE" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "NAME" NVARCHAR2

(100) NULL, "APP_LABEL" NVARCHAR2(100) NULL, "MODEL" NVARCHAR2(100) NULL);
--
-- Alter unique_together for contenttype (1 constraint(s))
--
ALTER TABLE "DJANGO_CONTENT_TYPE" ADD CONSTRAINT "DJANGO_CO_APP_LABEL_76BD3D3B_U" UNIQUE 

("APP_LABEL", "MODEL");

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'DJANGO_CONTENT_TYPE_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "DJANGO_CONTENT_TYPE_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "DJANGO_CONTENT_TYPE_TR"
BEFORE INSERT ON "DJANGO_CONTENT_TYPE"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "DJANGO_CONTENT_TYPE_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
COMMIT;


--
-- Change Meta options on contenttype
--
--
-- Alter field name on contenttype
--
--
-- MIGRATION NOW PERFORMS OPERATION THAT CANNOT BE WRITTEN AS SQL:
-- Raw Python operation
--
--
-- Remove field name from contenttype
--
ALTER TABLE "DJANGO_CONTENT_TYPE" DROP COLUMN "NAME";
COMMIT;


--
-- Create model Permission
--
CREATE TABLE "AUTH_PERMISSION" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "NAME" NVARCHAR2(50) 

NULL, "CONTENT_TYPE_ID" NUMBER(11) NOT NULL, "CODENAME" NVARCHAR2(100) NULL);
--
-- Create model Group
--
CREATE TABLE "AUTH_GROUP" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "NAME" NVARCHAR2(80) NULL 

UNIQUE);
CREATE TABLE "AUTH_GROUP_PERMISSIONS" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "GROUP_ID" 

NUMBER(11) NOT NULL, "PERMISSION_ID" NUMBER(11) NOT NULL);
--
-- Create model User
--

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'AUTH_PERMISSION_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "AUTH_PERMISSION_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "AUTH_PERMISSION_TR"
BEFORE INSERT ON "AUTH_PERMISSION"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "AUTH_PERMISSION_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
ALTER TABLE "AUTH_PERMISSION" ADD CONSTRAINT "AUTH_PERM_CONTENT_T_2F476E4B_F" FOREIGN KEY 

("CONTENT_TYPE_ID") REFERENCES "DJANGO_CONTENT_TYPE" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AUTH_PERMISSION" ADD CONSTRAINT "AUTH_PERM_CONTENT_T_01AB375A_U" UNIQUE 

("CONTENT_TYPE_ID", "CODENAME");
CREATE INDEX "AUTH_PERMI_CONTENT_TY_2F476E4B" ON "AUTH_PERMISSION" ("CONTENT_TYPE_ID");

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'AUTH_GROUP_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "AUTH_GROUP_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "AUTH_GROUP_TR"
BEFORE INSERT ON "AUTH_GROUP"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "AUTH_GROUP_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'AUTH_GROUP_PERMISSIONS_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "AUTH_GROUP_PERMISSIONS_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "AUTH_GROUP_PERMISSIONS_TR"
BEFORE INSERT ON "AUTH_GROUP_PERMISSIONS"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "AUTH_GROUP_PERMISSIONS_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
ALTER TABLE "AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "AUTH_GROU_GROUP_ID_B120CBF9_F" FOREIGN 

KEY ("GROUP_ID") REFERENCES "AUTH_GROUP" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "AUTH_GROU_PERMISSIO_84C5C92E_F" FOREIGN 

KEY ("PERMISSION_ID") REFERENCES "AUTH_PERMISSION" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "AUTH_GROU_GROUP_ID__0CD325B0_U" UNIQUE 

("GROUP_ID", "PERMISSION_ID");
CREATE INDEX "AUTH_GROUP_GROUP_ID_B120CBF9" ON "AUTH_GROUP_PERMISSIONS" ("GROUP_ID");
CREATE INDEX "AUTH_GROUP_PERMISSION_84C5C92E" ON "AUTH_GROUP_PERMISSIONS" ("PERMISSION_ID");
COMMIT;


--
-- Alter field name on permission
--
ALTER TABLE "AUTH_PERMISSION" MODIFY "NAME" NVARCHAR2(255);
COMMIT;


--
-- Create model Profile
--
CREATE TABLE "HOME_PROFILE" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "PASSWORD" NVARCHAR2(128) 

NULL, "LAST_LOGIN" TIMESTAMP NULL, "IS_SUPERUSER" NUMBER(1) NOT NULL CHECK ("IS_SUPERUSER" IN 

(0,1)), "USERNAME" NVARCHAR2(150) NULL UNIQUE, "FIRST_NAME" NVARCHAR2(30) NULL, "LAST_NAME" 

NVARCHAR2(30) NULL, "EMAIL" NVARCHAR2(254) NULL, "IS_STAFF" NUMBER(1) NOT NULL CHECK 

("IS_STAFF" IN (0,1)), "IS_ACTIVE" NUMBER(1) NOT NULL CHECK ("IS_ACTIVE" IN (0,1)), 

"DATE_JOINED" TIMESTAMP NOT NULL, "USER_PHOTO" NVARCHAR2(100) NULL);
CREATE TABLE "HOME_PROFILE_GROUPS" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "PROFILE_ID" 

NUMBER(11) NOT NULL, "GROUP_ID" NUMBER(11) NOT NULL);
CREATE TABLE "HOME_PROFILE_USER_PERMISSIONS" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, 

"PROFILE_ID" NUMBER(11) NOT NULL, "PERMISSION_ID" NUMBER(11) NOT NULL);


ALTER TABLE "HOME_PROFILE"
  ADD CONSTRAINT "USER_EMAIL_UNIQUE" UNIQUE ("EMAIL");

ALTER TABLE "HOME_PROFILE"
  ADD CONSTRAINT CHECK_EMAIL
  CHECK (REGEXP_LIKE (email, '[A-Za-z0-9._]+@[A-Za-z0-9._]+\.[A-Za-z]{2,15}'));

ALTER TABLE "HOME_PROFILE"
    ADD CONSTRAINT check_firstname
    CHECK ( REGEXP_LIKE ("LAST_NAME", '[A-Za-z ,-]{0,25}')); 

ALTER TABLE "HOME_PROFILE"
    ADD CONSTRAINT check_lastname
    CHECK ( REGEXP_LIKE ("FIRST_NAME", '[A-Za-z ,-]{0,25}')); 
COMMIT;

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'HOME_PROFILE_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "HOME_PROFILE_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "HOME_PROFILE_TR"
BEFORE INSERT ON "HOME_PROFILE"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "HOME_PROFILE_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'HOME_PROFILE_GROUPS_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "HOME_PROFILE_GROUPS_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "HOME_PROFILE_GROUPS_TR"
BEFORE INSERT ON "HOME_PROFILE_GROUPS"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "HOME_PROFILE_GROUPS_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
ALTER TABLE "HOME_PROFILE_GROUPS" ADD CONSTRAINT "HOME_PROF_PROFILE_I_9880A719_F" FOREIGN KEY 

("PROFILE_ID") REFERENCES "HOME_PROFILE" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "HOME_PROFILE_GROUPS" ADD CONSTRAINT "HOME_PROF_GROUP_ID_D62F98DD_F" FOREIGN KEY 

("GROUP_ID") REFERENCES "AUTH_GROUP" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "HOME_PROFILE_GROUPS" ADD CONSTRAINT "HOME_PROF_PROFILE_I_696FE3C4_U" UNIQUE 

("PROFILE_ID", "GROUP_ID");
CREATE INDEX "HOME_PROFI_PROFILE_ID_9880A719" ON "HOME_PROFILE_GROUPS" ("PROFILE_ID");
CREATE INDEX "HOME_PROFI_GROUP_ID_D62F98DD" ON "HOME_PROFILE_GROUPS" ("GROUP_ID");

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'HOME_PROFILE_USER_PERMI03BB';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "HOME_PROFILE_USER_PERMI03BB"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "HOME_PROFILE_USER_PERMIE75F"
BEFORE INSERT ON "HOME_PROFILE_USER_PERMISSIONS"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "HOME_PROFILE_USER_PERMI03BB".nextval
        INTO :new."ID" FROM dual;
    END;
/
ALTER TABLE "HOME_PROFILE_USER_PERMISSIONS" ADD CONSTRAINT "HOME_PROF_PROFILE_I_D16D606F_F" 

FOREIGN KEY ("PROFILE_ID") REFERENCES "HOME_PROFILE" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "HOME_PROFILE_USER_PERMISSIONS" ADD CONSTRAINT "HOME_PROF_PERMISSIO_7893867C_F" 

FOREIGN KEY ("PERMISSION_ID") REFERENCES "AUTH_PERMISSION" ("ID") DEFERRABLE INITIALLY 

DEFERRED;
ALTER TABLE "HOME_PROFILE_USER_PERMISSIONS" ADD CONSTRAINT "HOME_PROF_PROFILE_I_50D0B372_U" 

UNIQUE ("PROFILE_ID", "PERMISSION_ID");
CREATE INDEX "HOME_PROFI_PROFILE_ID_D16D606F" ON "HOME_PROFILE_USER_PERMISSIONS" 

("PROFILE_ID");
CREATE INDEX "HOME_PROFI_PERMISSION_7893867C" ON "HOME_PROFILE_USER_PERMISSIONS" 

("PERMISSION_ID");
COMMIT;


--
-- Create model LogEntry
--
CREATE TABLE "DJANGO_ADMIN_LOG" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "ACTION_TIME" 

TIMESTAMP NOT NULL, "OBJECT_ID" NCLOB NULL, "OBJECT_REPR" NVARCHAR2(200) NULL, "ACTION_FLAG" 

NUMBER(11) NOT NULL CHECK ("ACTION_FLAG" >= 0), "CHANGE_MESSAGE" NCLOB NULL, 

"CONTENT_TYPE_ID" NUMBER(11) NULL, "USER_ID" NUMBER(11) NOT NULL);

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'DJANGO_ADMIN_LOG_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "DJANGO_ADMIN_LOG_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "DJANGO_ADMIN_LOG_TR"
BEFORE INSERT ON "DJANGO_ADMIN_LOG"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "DJANGO_ADMIN_LOG_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
ALTER TABLE "DJANGO_ADMIN_LOG" ADD CONSTRAINT "DJANGO_AD_CONTENT_T_C4BCE8EB_F" FOREIGN KEY 

("CONTENT_TYPE_ID") REFERENCES "DJANGO_CONTENT_TYPE" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "DJANGO_ADMIN_LOG" ADD CONSTRAINT "DJANGO_AD_USER_ID_C564EBA6_F" FOREIGN KEY 

("USER_ID") REFERENCES "HOME_PROFILE" ("ID") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "DJANGO_ADM_CONTENT_TY_C4BCE8EB" ON "DJANGO_ADMIN_LOG" ("CONTENT_TYPE_ID");
CREATE INDEX "DJANGO_ADM_USER_ID_C564EBA6" ON "DJANGO_ADMIN_LOG" ("USER_ID");
COMMIT;


--
-- Create model Phone
--
CREATE TABLE "PHONES_PHONE" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "NAME" NVARCHAR2(30) NULL, 

"DESCRIPTION" NVARCHAR2(255) NULL, "PRICE" NUMBER(11) NULL CHECK ("PRICE" >= 0), "MODEL" 

NVARCHAR2(30) NULL, "QUANTITY" NUMBER(11) NOT NULL CHECK ("QUANTITY" >= 0), "PHONE_PHOTO" 

NVARCHAR2(100) NULL);

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'PHONES_PHONE_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "PHONES_PHONE_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "PHONES_PHONE_TR"
BEFORE INSERT ON "PHONES_PHONE"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "PHONES_PHONE_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
COMMIT;


--
-- Create model Order
--
CREATE TABLE "ORDERS_ORDER" ("ID" NUMBER(11) NOT NULL PRIMARY KEY, "QUANTITY" NUMBER(11) NOT 

NULL CHECK ("QUANTITY" >= 0), "CREATE_TIME" TIMESTAMP NULL, "PHONE_ID" NUMBER(11) NULL, 

"USER_ID" NUMBER(11) NULL);

DECLARE
    i INTEGER;
BEGIN
    SELECT COUNT(1) INTO i FROM USER_SEQUENCES
        WHERE SEQUENCE_NAME = 'ORDERS_ORDER_SQ';
    IF i = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE "ORDERS_ORDER_SQ"';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER "ORDERS_ORDER_TR"
BEFORE INSERT ON "ORDERS_ORDER"
FOR EACH ROW
WHEN (new."ID" IS NULL)
    BEGIN
        SELECT "ORDERS_ORDER_SQ".nextval
        INTO :new."ID" FROM dual;
    END;
/
ALTER TABLE "ORDERS_ORDER" ADD CONSTRAINT "ORDERS_OR_PHONE_ID_8788AD27_F" FOREIGN KEY 

("PHONE_ID") REFERENCES "PHONES_PHONE" ("ID") DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE "ORDERS_ORDER" ADD CONSTRAINT "ORDERS_OR_USER_ID_E9B59EB1_F" FOREIGN KEY 

("USER_ID") REFERENCES "HOME_PROFILE" ("ID") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "ORDERS_ORDER_PHONE_ID_8788AD27" ON "ORDERS_ORDER" ("PHONE_ID");
CREATE INDEX "ORDERS_ORDER_USER_ID_E9B59EB1" ON "ORDERS_ORDER" ("USER_ID");
COMMIT;


--
-- Create model Session
--
CREATE TABLE "DJANGO_SESSION" ("SESSION_KEY" NVARCHAR2(40) NOT NULL PRIMARY KEY, 

"SESSION_DATA" NCLOB NULL, "EXPIRE_DATE" TIMESTAMP NOT NULL);
CREATE INDEX "DJANGO_SES_EXPIRE_DAT_A5C62663" ON "DJANGO_SESSION" ("EXPIRE_DATE");
COMMIT;

--
-- Customs
--
CREATE or REPLACE TRIGGER "phoneQuantityExtract"
AFTER INSERT ON "ORDERS_ORDER"
FOR EACH ROW
    BEGIN
        UPDATE "PHONES_PHONE"
        SET "QUANTITY" = "QUANTITY" - :new."QUANTITY"
        WHERE "ID" = :new."PHONE_ID";
    END;
/
COMMIT;

CREATE OR REPLACE TRIGGER "ORDER_DATE_AUTOADD" BEFORE INSERT ON "ORDERS_ORDER"
FOR EACH ROW
BEGIN
 :NEW.CREATE_TIME := SYSDATE;
END;
/
COMMIT;

CREATE OR REPLACE FORCE VIEW "OrderDetailsPage" AS 
  SELECT 
    "PHONES_PHONE"."ID" "PHONE_ID", 
    "PHONES_PHONE"."PHONE_PHOTO" "PHONE_PHOTO_URL", 
    "PHONES_PHONE"."NAME" "PHONE_NAME", 
    "PHONES_PHONE"."MODEL" "PHONE_MODEL", 
    "PHONES_PHONE"."DESCRIPTION" "PHONE_DESCRIPTION", 
    "PHONES_PHONE"."PRICE" "PHONE_PRICE", 
    "PHONES_PHONE"."QUANTITY" "PHONE_QUANTITY",

    "HOME_PROFILE"."USERNAME" "USERNAME",

    "ORDERS_ORDER"."CREATE_TIME" "ORDER_CREATE_TIME",
    "ORDERS_ORDER"."QUANTITY" "ORDER_QUANTITY"
  FROM 
    "PHONES_PHONE" LEFT JOIN "ORDERS_ORDER" ON "PHONES_PHONE"."ID" = "ORDERS_ORDER"."PHONE_ID"
                   LEFT JOIN "HOME_PROFILE" ON "ORDERS_ORDER"."USER_ID" = "HOME_PROFILE"."ID";
COMMIT;



CREATE OR REPLACE PACKAGE order_package IS
PROCEDURE create_order_procedure (user_id INTEGER, phone_id INTEGER, quantity INTEGER);
END order_package ;

CREATE OR REPLACE PACKAGE BODY order_package IS 
PROCEDURE create_order_procedure (user_id INTEGER, phone_id INTEGER, quantity INTEGER) IS
   BEGIN
    INSERT INTO "ORDERS_ORDER" ("QUANTITY", "PHONE_ID", "USER_ID") 
    VALUES (quantity, phone_id, user_id);
   END;
END order_package ;
