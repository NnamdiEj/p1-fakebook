DROP TABLE Tags;
ALTER TABLE Albums
DROP CONSTRAINT COVER_PHOTO;
DROP TABLE Photos;
ALTER TABLE Photos
DROP CONSTRAINT PARENT_ALBUM;
DROP TABLE Albums;
DROP TABLE Participants;
DROP TABLE User_Events;
DROP TABLE Education;
DROP SEQUENCE program_id_seq;
DROP TRIGGER program_id_trigger;
DROP TABLE Programs;
DROP TABLE Messages;
DROP TABLE User_Hometown_Cities;
DROP TABLE User_Current_Cities;
DROP SEQUENCE city_id_seq;
DROP TRIGGER city_id_trigger;
DROP TABLE Cities;
DROP TRIGGER order_friends_pairs;
DROP TABLE Friends;
DROP TABLE Users;