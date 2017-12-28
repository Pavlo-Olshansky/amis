INSERT INTO "HOME_PROFILE" ("ID", "PASSWORD", "IS_SUPERUSER", "USER_PHOTO", "USERNAME", "FIRST_NAME", "LAST_NAME", "EMAIL", "IS_STAFF", "IS_ACTIVE", "DATE_JOINED")
VALUES (1, 'pbkdf2_sha256$36000$8yoV8qNy7JNm$y3ypl3hynYUmYhKv0xIZYyP5kGy7qNNuBm8sOz/rfig=', 1, 'no_profile.jpg', 'admin', 'Admin', 'Admin', 'admin@gmail.com', 0, 1, '26-DEC-17 03.04.07.834070000 AM');
INSERT INTO "HOME_PROFILE" ("ID", "PASSWORD", "IS_SUPERUSER", "USER_PHOTO", "USERNAME", "FIRST_NAME", "LAST_NAME", "EMAIL", "IS_STAFF", "IS_ACTIVE", "DATE_JOINED")
VALUES (2, 'pbkdf2_sha256$36000$BU9afluC9zyZ$NPiLUqZTr8Hk3N3baPsAR3KVZ3UIUQ1vYW3f9cG2+B0=', 0, 'no_profile.jpg', 'nazatron', 'Nazar', 'Kaminsky', 'kaminsky@gmail.com', 0, 1, '26-DEC-17 03.02.56.172971000 AM');
INSERT INTO "HOME_PROFILE" ("ID", "PASSWORD", "IS_SUPERUSER", "USER_PHOTO", "USERNAME", "FIRST_NAME", "LAST_NAME", "EMAIL", "IS_STAFF", "IS_ACTIVE", "DATE_JOINED")
VALUES (3, 'pbkdf2_sha256$36000$cLd2S1XVZeDu$IBlWbf6LOxj5+NMPRlCjVdgntQ92AjmYu1RroynRoow=', 0, 'no_profile.jpg', 'mavlia', 'Yarik', 'Mavliutov', 'mavliutov@gmail.com', 0, 1, '26-DEC-17 03.03.34.737177000 AM');

INSERT INTO "PHONES_PHONE" ("ID", "NAME", "DESCRIPTION", "PRICE", "MODEL", "QUANTITY", "PHONE_PHOTO") 
VALUES (1, 'Iphone 6', 'Cool phone for photoes !', 700, 'Iphone', 15, 'phone_image/iphone_6.jpg');
INSERT INTO "PHONES_PHONE" ("ID", "NAME", "DESCRIPTION", "PRICE", "MODEL", "QUANTITY", "PHONE_PHOTO") 
VALUES (2, 'Iphone 7', 'Coolest phone for selfies!', 800, 'Iphone', 10, 'phone_image/iphone_7.png');
INSERT INTO "PHONES_PHONE" ("ID", "NAME", "DESCRIPTION", "PRICE", "MODEL", "QUANTITY", "PHONE_PHOTO") 
VALUES (3, 'Iphone X', 'The most coolest phone !', 900, 'Iphone', 5, 'phone_image/iphone_8.jpg');

INSERT INTO "ORDERS_ORDER" ("ID", "QUANTITY", "CREATE_TIME", "PHONE_ID", "USER_ID") 
VALUES (1, 3, '26-DEC-17 03.17.31.075013000 AM', 1, 1);
INSERT INTO "ORDERS_ORDER" ("ID", "QUANTITY", "CREATE_TIME", "PHONE_ID", "USER_ID") 
VALUES (2, 2, '26-DEC-17 03.18.25.042100000 AM', 2, 2);
INSERT INTO "ORDERS_ORDER" ("ID", "QUANTITY", "CREATE_TIME", "PHONE_ID", "USER_ID") 
VALUES (3, 1, '26-DEC-17 03.18.31.306458000 AM', 3, 3);
COMMIT;
