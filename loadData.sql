-- noinspection SqlResolveForFile

-- USERS TABLE
INSERT INTO
    Users (USER_ID,
           FIRST_NAME,
           LAST_NAME,
           YEAR_OF_BIRTH,
           MONTH_OF_BIRTH,
           DAY_OF_BIRTH,
           GENDER)
SELECT
       USER_ID,
       FIRST_NAME,
       LAST_NAME,
       YEAR_OF_BIRTH,
       MONTH_OF_BIRTH,
       DAY_OF_BIRTH,
       GENDER
FROM PUBLIC_USER_INFORMATION;

-- FRIENDS TABLE
INSERT INTO
    Friends (USER1_ID,
             USER2_ID)
SELECT
       USER1_ID,
       USER2_ID
FROM PUBLIC_ARE_FRIENDS;

-- CITIES TABLE
INSERT INTO
    Cities (CITY_NAME,
            STATE_NAME,
            COUNTRY_NAME)
SELECT DISTINCT
                CURRENT_CITY,
                CURRENT_STATE,
                CURRENT_COUNTRY
FROM PUBLIC_USER_INFORMATION;

INSERT INTO Cities
    (CITY_NAME,
     STATE_NAME,
     COUNTRY_NAME)
SELECT
       HOMETOWN_CITY,
       HOMETOWN_STATE,
       HOMETOWN_COUNTRY
FROM PUBLIC_USER_INFORMATION;

INSERT INTO Cities
    (CITY_NAME,
     STATE_NAME,
     COUNTRY_NAME)
SELECT
       EVENT_CITY,
       EVENT_STATE,
       EVENT_COUNTRY
FROM PUBLIC_EVENT_INFORMATION;

-- USER CURRENT CITIES TABLE
INSERT INTO User_Current_Cities
    (USER_ID,
     CURRENT_CITY_ID)
SELECT
       U.USER_ID,
       C.CITY_ID
FROM Users U, Cities C
WHERE
      U.CURRENT_CITY = C.CITY_NAME AND
      U.CURRENT_STATE = C.STATE_NAME AND
      U.CURRENT_COUNTRY = C.COUNTRY_NAME;

-- USER HOMETOWN CITIES TABLE
INSERT INTO User_Hometown_Cities
    (USER_ID,
     CURRENT_CITY_ID)
SELECT
       U.USER_ID,
       C.CITY_ID
FROM Users U, Cities C
WHERE U.HOMETOWN_CITY = C.CITY_NAME AND
      U.HOMETOWN_STATE = C.STATE_NAME AND
      U.HOMETOWN_COUNTRY = C.COUNTRY_NAME;

-- PROGRAMS TABLE
INSERT INTO Programs
    (INSTITUTION,
     CONCENTRATION,
     DEGREE)
SELECT DISTINCT
                INSTITUTION_NAME,
                PROGRAM_CONCENTRATION,
                PROGRAM_DEGREE
FROM PUBLIC_USER_INFORMATION;

-- EDUCATION TABLE
INSERT INTO Education
    (USER_ID,
     PROGRAM_ID,
     PROGRAM_YEAR)
SELECT
       U.USER_ID,
       P.PROGRAM_ID,
       U.PROGRAM_YEAR
FROM PUBLIC_USER_INFORMATION U, Programs P
WHERE U.INSTITUTION_NAME = P.INSTITUTION AND
      U.PROGRAM_CONCENTRATION = P.CONCENTRATION AND
      U.PROGRAM_DEGREE = P.DEGREE;

-- USER EVENTS TABLE
INSERT INTO User_Events
    (EVENT_ID,
     EVENT_CREATOR_ID,
     EVENT_NAME,
     EVENT_TAGLINE,
     EVENT_DESCRIPTION,
     EVENT_HOST,
     EVENT_TYPE,
     EVENT_SUBTYPE,
     EVENT_ADDRESS,
     EVENT_CITY_ID,
     EVENT_START_TIME,
     EVENT_END_TIME)
SELECT
       E.EVENT_ID,
       E.EVENT_CREATOR_ID,
       E.EVENT_NAME,
       E.EVENT_TAGLINE,
       E.EVENT_DESCRIPTION,
       E.EVENT_HOST,
       E.EVENT_TYPE,
       E.EVENT_SUBTYPE,
       E.EVENT_ADDRESS,
       C.EVENT_CITY_ID,
       E.EVENT_START_TIME,
       E.EVENT_END_TIME
FROM PUBLIC_EVENT_INFORMATION E, Cities C
WHERE E.EVENT_CITY = C.CITY_NAME AND
      E.EVENT_STATE = C.STATE_NAME AND
      E.EVENT_COUNTRY = C.COUNTRY_NAME;

-- ALBUMS TABLE
INSERT INTO Albums
    (ALBUM_ID,
     ALBUM_OWNER_ID,
     ALBUM_NAME,
     ALBUM_CREATED_TIME,
     ALBUM_MODIFIED_TIME,
     ALBUM_LINK,
     ALBUM_VISIBILITY,
     COVER_PHOTO_ID)
SELECT DISTINCT
                ALBUM_ID,
                OWNER_ID,
                ALBUM_NAME,
                ALBUM_CREATED_TIME,
                ALBUM_MODIFIED_TIME,
                ALBUM_LINK,
                ALBUM_VISIBILITY,
                COVER_PHOTO_ID
FROM PUBLIC_PHOTO_INFORMATION;

-- PHOTOS TABLE
INSERT INTO Photos
    (PHOTO_ID,
     ALBUM_ID,
     PHOTO_CAPTION,
     PHOTO_CREATED_TIME,
     PHOTO_MODIFIED_TIME,
     PHOTO_LINK)
SELECT
       PHOTO_ID,
       ALBUM_ID,
       PHOTO_CAPTION,
       PHOTO_CREATED_TIME,
       PHOTO_MODIFIED_TIME,
       PHOTO_LINK
FROM PUBLIC_PHOTO_INFORMATION;

-- TAGS TABLE
INSERT INTO Tags
    (TAG_PHOTO_ID,
     TAG_SUBJECT_ID,
     TAG_CREATED_TIME,
     TAG_X,
     TAG_Y)
SELECT
       PHOTO_ID,
       TAG_SUBJECT_ID,
       TAG_CREATED_TIME,
       TAG_X_COORDINATE,
       TAG_Y_COORDINATE
FROM PUBLIC_TAG_INFORMATION;