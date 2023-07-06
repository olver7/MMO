DECLARE @CustomerGUID uniqueidentifier = ''

DECLARE @CountOfHubWorldMaps int = 0

SELECT @CountOfHubWorldMaps=COUNT(*) FROM Maps WHERE CustomerGUID=@CustomerGUID AND ZoneName='HubWorld'

IF (@CountOfHubWorldMaps < 1)
BEGIN

INSERT INTO Maps ([CustomerGUID], [MapName], [MapData], [Width], [Height], [ZoneName], [WorldCompContainsFilter], [WorldCompListFilter], [MapMode], [SoftPlayerCap], [HardPlayerCap], [MinutesToShutdownAfterEmpty])
VALUES (@CustomerGUID, 'HubWorldMap', NULL, 1, 1, 'HubWorld', '', '', 1, 60, 80, 1)

END

SET @CountOfHubWorldMaps = 0

SELECT @CountOfHubWorldMaps=COUNT(*) FROM Maps WHERE CustomerGUID=@CustomerGUID AND ZoneName='SouthGate'

IF (@CountOfHubWorldMaps < 1)
BEGIN

INSERT INTO Maps ([CustomerGUID], [MapName], [MapData], [Width], [Height], [ZoneName], [WorldCompContainsFilter], [WorldCompListFilter], [MapMode], [SoftPlayerCap], [HardPlayerCap], [MinutesToShutdownAfterEmpty])
VALUES (@CustomerGUID, 'HubWorldMap', NULL, 1, 1, 'SouthGate', '', '', 1, 60, 80, 1)

END

DECLARE @DefaultCharacterValuesID int = 0
DECLARE @CountOfDefaultCharacterValues int = 0

SELECT @CountOfDefaultCharacterValues=COUNT(*) FROM DefaultCharacterValues WHERE CustomerGUID=@CustomerGUID AND DefaultSetName='Default'

IF (@CountOfDefaultCharacterValues < 1)
BEGIN

INSERT INTO DefaultCharacterValues (CustomerGUID, DefaultSetName, StartingMapName, X, Y, Z, RX, RY, RZ)
VALUES (@CustomerGUID, 'Default', 'HubWorld', 1510, -160, 100, 0, 0, 0)

SELECT @DefaultCharacterValuesID=SCOPE_IDENTITY()

INSERT INTO DefaultCustomCharacterData (CustomerGUID, DefaultCharacterValuesID, CustomFieldName, FieldValue)
VALUES (@CustomerGUID, @DefaultCharacterValuesID, 'BaseCharacterStats', '{"Strength": 10, "Agility": 10, "Constitution": 10 }')
INSERT INTO DefaultCustomCharacterData (CustomerGUID, DefaultCharacterValuesID, CustomFieldName, FieldValue)
VALUES (@CustomerGUID, @DefaultCharacterValuesID, 'BaseCharacterSkills', '{ "Skill1": 1 }')
INSERT INTO DefaultCustomCharacterData (CustomerGUID, DefaultCharacterValuesID, CustomFieldName, FieldValue)
VALUES (@CustomerGUID, @DefaultCharacterValuesID, 'SupplyPodsOpened', '{}')
INSERT INTO DefaultCustomCharacterData (CustomerGUID, DefaultCharacterValuesID, CustomFieldName, FieldValue)
VALUES (@CustomerGUID, @DefaultCharacterValuesID, 'BagInventory', '{   "items": [] }')

END
