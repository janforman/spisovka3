ALTER TABLE [orgjednotka]
  CHANGE [sekvence] [sekvence] varchar(150) NOT NULL,
  CHANGE [sekvence_string] [sekvence_string] varchar(1000) NOT NULL;

ALTER TABLE [spis]
  CHANGE [sekvence] [sekvence] varchar(150) NOT NULL,
  CHANGE [sekvence_string] [sekvence_string] varchar(1000) NOT NULL;

ALTER TABLE [spisovy_znak]
  CHANGE [sekvence] [sekvence] varchar(150) NOT NULL,
  CHANGE [sekvence_string] [sekvence_string] varchar(1000) NOT NULL;

UPDATE [user_role] SET [sekvence] = [id] WHERE [sekvence] IS NULL;
UPDATE [user_role] SET [sekvence_string] = CONCAT('zz', [name], '.', [id]) WHERE [sekvence_string] IS NULL;

ALTER TABLE [user_role]
  CHANGE [sekvence] [sekvence] varchar(150) NOT NULL,
  CHANGE [sekvence_string] [sekvence_string] varchar(1000) NOT NULL;
