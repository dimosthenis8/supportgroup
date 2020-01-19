DROP DATABASE data; #when you run it for the first time this needs to be in comments
CREATE DATABASE data;
USE data;
SET sql_mode = "";

CREATE TABLE ActualTotalLoad (
  Id               int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt  timestamp(6) NOT NULL,
  EntityModifiedAt timestamp(6) NOT NULL,
  ActionTaskID     bigint(20) NOT NULL,
  Status           varchar(2),
  Year             int(11) NOT NULL,
  Month            int(11) NOT NULL,
  Day              int(11) NOT NULL,
  DateTime         datetime(6) NOT NULL,
  AreaName         varchar(200),
  UpdateTime       datetime(6) NOT NULL,
  TotalLoadValue   decimal(24, 2) NOT NULL,
  AreaTypeCodeId   int(11),
  AreaCodeId       int(11) NOT NULL,
  ResolutionCodeId int(11),
  MapCodeId        int(11),
  RowHash          varchar(255),
  CONSTRAINT `PK_ActualTotalLoad `
    PRIMARY KEY (Id));

CREATE INDEX `IX_ActualTotalLoad _ResolutionCodeId`
  ON ActualTotalLoad (ResolutionCodeId);
CREATE INDEX `IX_ActualTotalLoad _AreaCodeId`
  ON ActualTotalLoad (AreaCodeId);
CREATE INDEX `IX_ActualTotalLoad _AreaTypeCodeId`
  ON ActualTotalLoad (AreaTypeCodeId);
CREATE INDEX `IX_ActualTotalLoad _MapCodeId`
  ON ActualTotalLoad (MapCodeId);

CREATE TABLE AggregatedGenerationPerType (
  Id                     int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt        timestamp(6) NOT NULL,
  EntityModifiedAt       timestamp(6) NOT NULL,
  ActionTaskID           bigint(20) NOT NULL,
  Status                 varchar(2),
  Year                   int(11) NOT NULL,
  Month                  int(11) NOT NULL,
  Day                    int(11) NOT NULL,
  DateTime               datetime(6) NOT NULL,
  AreaName               varchar(200),
  UpdateTime             datetime(6) NOT NULL,
  ActualGenerationOutput decimal(24, 2) NOT NULL,
  ActualConsuption       decimal(24, 2) NOT NULL,
  AreaTypeCodeId         int(11),
  AreaCodeId             int(11) NOT NULL,
  ResolutionCodeId       int(11),
  MapCodeId              int(11),
  ProductionTypeId       int(11),
  RowHash                varchar(255),
  CONSTRAINT `PK_AggregatedGenerationPerType `
    PRIMARY KEY (Id));
    
CREATE INDEX `IX_AggregatedGenerationPerType _AreaCodeId`
  ON AggregatedGenerationPerType (AreaCodeId);
CREATE INDEX `IX_AggregatedGenerationPerType _ResolutionCodeId`
  ON AggregatedGenerationPerType (ResolutionCodeId);
CREATE INDEX `IX_AggregatedGenerationPerType _ProductionTypeId`
  ON AggregatedGenerationPerType (ProductionTypeId);
CREATE INDEX `IX_AggregatedGenerationPerType _MapCodeId`
  ON AggregatedGenerationPerType (MapCodeId);
CREATE INDEX `IX_AggregatedGenerationPerType _AreaTypeCodeId`
  ON AggregatedGenerationPerType (AreaTypeCodeId);


CREATE TABLE AllocatedEICDetail (
  Id                                    int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt                       timestamp(6) NOT NULL,
  EntityModifiedAt                      timestamp(6) NOT NULL,
  MRID                                  varchar(250),
  DocStatusValue                        varchar(250),
  AttributeInstanceComponent            varchar(250),
  LongNames                             varchar(250),
  DisplayNames                          varchar(250),
  LastRequestDateAndOrTime              datetime(6) NULL,
  DeactivateRequestDateAndOrTime        datetime(6) NULL,
  MarketParticipantStreetAddressCountry varchar(250),
  MarketParticipantACERCode             varchar(250),
  MarketParticipantVATcode              varchar(250),
  Description                           varchar(255),
  EICParentMarketDocumentMRID           varchar(250),
  ELCResponsibleMarketParticipantMRID   varchar(250),
  IsDeleted                             bit(1) NOT NULL,
  CONSTRAINT PK_AllocatedEICDetail
    PRIMARY KEY (Id));


CREATE TABLE AreaTypeCode (
  Id               int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt  timestamp(6) NOT NULL,
  EntityModifiedAt timestamp(6) NOT NULL, 
  AreaTypeCodeText varchar(255),
  AreaTypeCodeNote varchar(255),
  CONSTRAINT PK_AreaTypeCode
    PRIMARY KEY (Id));
CREATE UNIQUE INDEX IX_AreaTypeCode_AreaTypeCodeText
  ON AreaTypeCode (AreaTypeCodeText);


CREATE TABLE DayAheadTotalLoadForecast (
  Id               int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt  timestamp(6) NOT NULL,
  EntityModifiedAt timestamp(6) NOT NULL,
  ActionTaskID     bigint(20) NOT NULL,
  Status           varchar(2),
  Year             int(11) NOT NULL,
  Month            int(11) NOT NULL,
  Day              int(11) NOT NULL,
  DateTime         datetime(6) NOT NULL,
  AreaName         varchar(200),
  UpdateTime       datetime(6) NOT NULL,
  TotalLoadValue   decimal(24, 2) NOT NULL,
  AreaTypeCodeId   int(11),
  AreaCodeId       int(11) NOT NULL,
  ResolutionCodeId int(11),
  MapCodeId        int(11),
  RowHash          varchar(255),
  CONSTRAINT PK_DayAheadTotalLoadForecast
    PRIMARY KEY (Id));
    
CREATE INDEX IX_DayAheadTotalLoadForecast_MapCodeId
  ON DayAheadTotalLoadForecast (MapCodeId);
CREATE INDEX IX_DayAheadTotalLoadForecast_AreaTypeCodeId
  ON DayAheadTotalLoadForecast (AreaTypeCodeId);
CREATE INDEX IX_DayAheadTotalLoadForecast_AreaCodeId
  ON DayAheadTotalLoadForecast (AreaCodeId);
CREATE INDEX IX_DayAheadTotalLoadForecast_ResolutionCodeId
  ON DayAheadTotalLoadForecast (ResolutionCodeId);

CREATE TABLE MapCode (
  Id               int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt  timestamp(6) NOT NULL,
  EntityModifiedAt timestamp(6) NOT NULL, 
  MapCodeText      varchar(255),
  MapCodeNote      varchar(255),
  CONSTRAINT PK_MapCode
    PRIMARY KEY (Id));
CREATE UNIQUE INDEX IX_MapCode_MapCodeText
  ON MapCode (MapCodeText);


CREATE TABLE ProductionType (
  Id                 int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt    timestamp(6) NOT NULL,
  EntityModifiedAt   timestamp(6) NOT NULL, 
  ProductionTypeText varchar(255),
  ProductionTypeNote varchar(255),
  CONSTRAINT PK_ProductionType
    PRIMARY KEY (Id));
CREATE UNIQUE INDEX IX_ProductionType_ProductionTypeText
  ON ProductionType (ProductionTypeText);


CREATE TABLE ResolutionCode (
  Id                 int(11) NOT NULL AUTO_INCREMENT,
  EntityCreatedAt    timestamp(6) NOT NULL,
  EntityModifiedAt   timestamp(6) NOT NULL, 
  ResolutionCodeText varchar(255),
  ResolutionCodeNote varchar(255),
  CONSTRAINT PK_ResolutionCode
    PRIMARY KEY (Id));
CREATE UNIQUE INDEX IX_ResolutionCode_ResolutionCodeText
  ON ResolutionCode (ResolutionCodeText);


ALTER TABLE ActualTotalLoad  ADD CONSTRAINT FKActualTota167504 FOREIGN KEY (AreaCodeId) REFERENCES AllocatedEICDetail (Id);
ALTER TABLE ActualTotalLoad ADD CONSTRAINT FK_ActualTotalLoad_AreaTypeCode_AreaTypeCodeId FOREIGN KEY (AreaTypeCodeId) REFERENCES AreaTypeCode (Id) ON UPDATE No action ON DELETE No action;
ALTER TABLE ActualTotalLoad ADD CONSTRAINT FK_ActualTotalLoad_MapCode_MapCodeId FOREIGN KEY (MapCodeId) REFERENCES MapCode (Id) ON UPDATE No action ON DELETE No action;
ALTER TABLE ActualTotalLoad ADD CONSTRAINT FK_ActualTotalLoad_ResolutionCode_ResolutionCodeId FOREIGN KEY (ResolutionCodeId) REFERENCES ResolutionCode (Id) ON UPDATE No action ON DELETE No action;


ALTER TABLE AggregatedGenerationPerType ADD CONSTRAINT FKAggregated783487 FOREIGN KEY (AreaCodeId) REFERENCES AllocatedEICDetail (Id);
ALTER TABLE AggregatedGenerationPerType ADD CONSTRAINT FK_AggregatedGenerationPerType_AreaTypeCode_AreaTypeCodeId FOREIGN KEY (AreaTypeCodeId) REFERENCES AreaTypeCode (Id) ON UPDATE No action ON DELETE No action;
ALTER TABLE AggregatedGenerationPerType ADD CONSTRAINT FK_AggregatedGenerationPerType_MapCode_MapCodeId FOREIGN KEY (MapCodeId) REFERENCES MapCode (Id) ON UPDATE No action ON DELETE No action;
ALTER TABLE AggregatedGenerationPerType ADD CONSTRAINT FK_AggregatedGenerationPerType_ProductionType_ProductionTypeId FOREIGN KEY (ProductionTypeId) REFERENCES ProductionType (Id) ON UPDATE No action ON DELETE No action;
ALTER TABLE AggregatedGenerationPerType ADD CONSTRAINT FK_AggregatedGenerationPerType_ResolutionCode_ResolutionCodeId FOREIGN KEY (ResolutionCodeId) REFERENCES ResolutionCode (Id) ON UPDATE No action ON DELETE No action;

ALTER TABLE DayAheadTotalLoadForecast ADD CONSTRAINT FKDayAheadTo524780 FOREIGN KEY (AreaCodeId) REFERENCES AllocatedEICDetail (Id);
ALTER TABLE DayAheadTotalLoadForecast ADD CONSTRAINT FK_DayAheadTotalLoadForecast_AreaTypeCode_AreaTypeCodeId FOREIGN KEY (AreaTypeCodeId) REFERENCES AreaTypeCode (Id) ON UPDATE No action ON DELETE No action;
ALTER TABLE DayAheadTotalLoadForecast ADD CONSTRAINT FK_DayAheadTotalLoadForecast_MapCode_MapCodeId FOREIGN KEY (MapCodeId) REFERENCES MapCode (Id) ON UPDATE No action ON DELETE No action;
ALTER TABLE DayAheadTotalLoadForecast ADD CONSTRAINT FK_DayAheadTotalLoadForecast_ResolutionCode_ResolutionCodeId FOREIGN KEY (ResolutionCodeId) REFERENCES ResolutionCode (Id) ON UPDATE No action ON DELETE No action;



LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\AreaTypeCode.csv'
INTO TABLE AreaTypeCode
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ResolutionCode.csv'
INTO TABLE ResolutionCode
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ProductionType.csv'
INTO TABLE ProductionType
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\MapCode.csv'
INTO TABLE MapCode
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\AllocatedEICDetail.csv'
INTO TABLE AllocatedEICDetail
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DayAheadTotalLoadForecast-10days.csv'
INTO TABLE DayAheadTotalLoadForecast
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\ActualTotalLoad-10days.csv'
INTO TABLE ActualTotalLoad
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\AggregatedGenerationPerType-10days.csv'
INTO TABLE AggregatedGenerationPerType
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


#1a
SELECT 'entso-e' AS Source, 'ActualTotalLoad' AS Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, DateTime as DateTimeUTC, TotalLoadValue as ActualTotalLoadValue, UpdateTime as UpdateTimeUTC
FROM ActualTotalLoad, ResolutionCode, AreaTypeCode, MapCode
WHERE AreaName='Greece' AND ResolutionCodeText='PT60M' AND ResolutionCode.Id = ResolutionCodeId AND MapCode.Id=MapCodeId AND AreaTypeCode.Id=AreaTypeCodeId AND Month = 1 AND Day = 8 AND Year = 2018;

#1b
SELECT 'entso-e' AS Source, 'ActualTotalLoad' AS Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, sum(TotalLoadValue) as ActualTotalLoadValue
FROM ActualTotalLoad, ResolutionCode, AreaTypeCode, MapCode
WHERE AreaName='Greece' AND ResolutionCodeText='PT60M' AND ResolutionCode.Id = ResolutionCodeId AND MapCode.Id=MapCodeId AND AreaTypeCode.Id=AreaTypeCodeId AND Month = 1 AND Year = 2018
GROUP BY ActualTotalLoad.Day;

#1c
SELECT 'entso-e' AS Source, 'ActualTotalLoad' AS Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, sum(TotalLoadValue) as ActualTotalLoadValue
FROM ActualTotalLoad, ResolutionCode, AreaTypeCode, MapCode
WHERE AreaName='Greece' AND ResolutionCodeText='PT60M' AND ResolutionCode.Id = ResolutionCodeId AND MapCode.Id=MapCodeId AND AreaTypeCode.Id=AreaTypeCodeId AND Year = 2018
GROUP BY ActualTotalLoad.Month;

#2a
SELECT 'entso-e' as Source, "AggregatedGenerationPerType" as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, DateTime as DateTimeUTC, ProductionTypeText as ProductionType, ActualGenerationOutput as ActualGenerationOutputValue, UpdateTime as UpdateTimeUTC FROM  AggregatedGenerationPerType, AreaTypeCode, MapCode, ResolutionCode, ProductionType WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND ProductionType.Id = ProductionTypeId AND AreaName='Greece' AND ResolutionCodeText='PT60M' AND ProductionTypeText= 'Fossil Gas' AND Year = 2018 AND Month=1 AND Day=8;
#2a if ProductionTypeText='AllTypes'
SELECT 'entso-e' as Source, "AggregatedGenerationPerType" as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, DateTime as DateTimeUTC, ProductionTypeText as ProductionType, ActualGenerationOutput as ActualGenerationOutputValue, UpdateTime as UpdateTimeUTC FROM  AggregatedGenerationPerType, AreaTypeCode, MapCode, ResolutionCode, ProductionType WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND ProductionType.Id = ProductionTypeId AND AreaName='Greece' AND ResolutionCodeText='PT60M' AND Year = 2018 AND Month=1 AND Day=8 ORDER BY ProductionType.Id;

#2b
SELECT 'entso-e' as Source, "AggregatedGenerationPerType" as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, ProductionTypeText as ProductionType, sum(ActualGenerationOutput) as ActualGenerationOutputByDayValue
FROM  AggregatedGenerationPerType, AreaTypeCode, MapCode, ResolutionCode, ProductionType
WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND ProductionType.Id = ProductionTypeId AND AreaName='Greece' AND ResolutionCodeText='PT60M' AND ProductionTypeText= 'Fossil Gas' AND Year = 2018 AND Month=1
GROUP BY AggregatedGenerationPerType.Day;
#2b if ProductionTypeText='AllTypes'
SELECT 'entso-e' as Source, "AggregatedGenerationPerType" as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, ProductionTypeText as ProductionType, sum(ActualGenerationOutput) as ActualGenerationOutputByDayValue
FROM  AggregatedGenerationPerType, AreaTypeCode, MapCode, ResolutionCode, ProductionType
WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND ProductionType.Id = ProductionTypeId AND AreaName='Greece' AND ResolutionCodeText='PT60M' AND Year = 2018 AND Month=1
GROUP BY AggregatedGenerationPerType.Day, ProductionType.Id ;

#2c
SELECT 'entso-e' as Source, "AggregatedGenerationPerType" as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, ProductionTypeText as ProductionType, sum(ActualGenerationOutput) as ActualGenerationOutputByMonthValue
FROM  AggregatedGenerationPerType, AreaTypeCode, MapCode, ResolutionCode, ProductionType
WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND ProductionType.Id = ProductionTypeId AND AreaName='Greece' AND ResolutionCodeText='PT60M' AND ProductionTypeText= 'Fossil Gas' AND Year = 2018
GROUP BY AggregatedGenerationPerType.Month;
#2c if ProductionTypeText='AllTypes'
SELECT 'entso-e' as Source, "AggregatedGenerationPerType" as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, ProductionTypeText as ProductionType, sum(ActualGenerationOutput) as ActualGenerationOutputByMonthValue
FROM  AggregatedGenerationPerType, AreaTypeCode, MapCode, ResolutionCode, ProductionType
WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND ProductionType.Id = ProductionTypeId AND AreaName='Greece' AND ResolutionCodeText='PT60M' AND Year = 2018
GROUP BY AggregatedGenerationPerType.Month, ProductionType.Id;

#3a
SELECT 'entso-e' as Source, 'DayAheadTotalLoadForecast' as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, Datetime as DateTimeUTC, TotalLoadValue as DayAheadTotalLoadForecastValue, UpdateTime as UpdateTimeUTC
FROM DayAheadTotalLoadForecast, AreaTypeCode, MapCode, ResolutionCode
WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND AreaName='Greece' AND ResolutionCodeText='PT60M' AND Year = 2018 AND Month=1 AND Day=8;

#3b
SELECT 'entso-e' as Source, 'DayAheadTotalLoadForecast' as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, Day, sum(TotalLoadValue) as DayAheadTotalLoadForecastByDayValue
FROM DayAheadTotalLoadForecast, AreaTypeCode, MapCode, ResolutionCode
WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND Year = 2018 AND Month = 1 AND AreaName = 'Slovakia'
GROUP BY DayAheadTotalLoadForecast.Day;

#3c
SELECT 'entso-e' as Source, 'DayAheadTotalLoadForecast' as Dataset, AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, Year, Month, sum(TotalLoadValue) as DayAheadTotalLoadForecastByDayValue
FROM DayAheadTotalLoadForecast, AreaTypeCode, MapCode, ResolutionCode
WHERE AreaTypeCode.Id = AreaTypeCodeId AND MapCode.Id = MapCodeId AND ResolutionCode.Id = ResolutionCodeId AND Year = 2018 AND AreaName = 'Slovakia' AND ResolutionCodeText='PT60M'
GROUP BY DayAheadTotalLoadForecast.Month;


#4a
SELECT 'entso-e' as Source, 'ActualVSForecastedTotalLoad' as Dataset, ActualTotalLoad.AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, ActualTotalLoad.Year, ActualTotalLoad.Month, ActualTotalLoad.Day, ActualTotalLoad.DateTime as DateTimeUTC, DayAheadTotalLoadForecast.TotalLoadValue as DayAheadTotalLoadForecastValue, ActualTotalLoad.TotalLoadValue as ActualTotalLoadValue
FROM AreaTypeCode, MapCode, ResolutionCode, ActualTotalLoad, DayAheadTotalLoadForecast
WHERE AreaTypeCode.Id = ActualTotalLoad.AreaTypeCodeId AND AreaTypeCode.Id = DayAheadTotalLoadForecast.AreaTypeCodeId AND MapCode.Id = DayAheadTotalLoadForecast.MapCodeId AND MapCode.Id = ActualTotalLoad.MapCodeId AND ResolutionCode.Id = DayAheadTotalLoadForecast.ResolutionCodeId AND ResolutionCode.Id = ActualTotalLoad.ResolutionCodeId AND ActualTotalLoad.AreaName = 'Greece' AND ResolutionCodeText='PT60M' AND ActualTotalLoad.Day = 8 AND ActualTotalLoad.Month = 1 AND ActualTotalLoad.Year = 2018 AND ActualTotalLoad.Day = DayAheadTotalLoadForecast.Day AND ActualTotalLoad.Month = DayAheadTotalLoadForecast.Month AND ActualTotalLoad.Year = DayAheadTotalLoadForecast.Year AND ActualTotalLoad.DateTime = DayAheadTotalLoadForecast.DateTime;


#4b
SELECT 'entso-e' as Source, 'ActualVSForecastedTotalLoad' as Dataset, ActualTotalLoad.AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, ActualTotalLoad.Year, ActualTotalLoad.Month, ActualTotalLoad.Day, sum(DayAheadTotalLoadForecast.TotalLoadValue) as DayAheadTotalLoadForecastByDayValue, sum(ActualTotalLoad.TotalLoadValue) as ActualTotalLoadByDayValue
FROM AreaTypeCode, MapCode, ResolutionCode, ActualTotalLoad, DayAheadTotalLoadForecast
WHERE AreaTypeCode.Id = ActualTotalLoad.AreaTypeCodeId AND AreaTypeCode.Id = DayAheadTotalLoadForecast.AreaTypeCodeId AND MapCode.Id = DayAheadTotalLoadForecast.MapCodeId AND MapCode.Id = ActualTotalLoad.MapCodeId AND ResolutionCode.Id = DayAheadTotalLoadForecast.ResolutionCodeId AND ResolutionCode.Id = ActualTotalLoad.ResolutionCodeId AND ActualTotalLoad.AreaName = 'Greece' AND ResolutionCodeText='PT60M' AND ActualTotalLoad.Month = 1 AND ActualTotalLoad.Year = 2018 AND ActualTotalLoad.Day = DayAheadTotalLoadForecast.Day AND ActualTotalLoad.Month = DayAheadTotalLoadForecast.Month AND ActualTotalLoad.Year = DayAheadTotalLoadForecast.Year
GROUP BY ActualTotalLoad.Day;


#4c
SELECT 'entso-e' as Source, 'ActualVSForecastedTotalLoad' as Dataset, ActualTotalLoad.AreaName, AreaTypeCodeText as AreaTypeCode, MapCodeText as MapCode, ResolutionCodeText as ResolutionCode, ActualTotalLoad.Year, ActualTotalLoad.Month, sum(DayAheadTotalLoadForecast.TotalLoadValue) as DayAheadTotalLoadForecastByMonthValue, sum(ActualTotalLoad.TotalLoadValue) as ActualTotalLoadByMonthValue
FROM AreaTypeCode, MapCode, ResolutionCode, ActualTotalLoad, DayAheadTotalLoadForecast
WHERE AreaTypeCode.Id = ActualTotalLoad.AreaTypeCodeId AND AreaTypeCode.Id = DayAheadTotalLoadForecast.AreaTypeCodeId AND MapCode.Id = DayAheadTotalLoadForecast.MapCodeId AND MapCode.Id = ActualTotalLoad.MapCodeId AND ResolutionCode.Id = DayAheadTotalLoadForecast.ResolutionCodeId AND ResolutionCode.Id = ActualTotalLoad.ResolutionCodeId AND ActualTotalLoad.AreaName = 'Greece' AND ResolutionCodeText='PT60M' AND ActualTotalLoad.Year = 2018 AND ActualTotalLoad.Day = DayAheadTotalLoadForecast.Day AND ActualTotalLoad.Month = DayAheadTotalLoadForecast.Month AND ActualTotalLoad.Year = DayAheadTotalLoadForecast.Year
GROUP BY ActualTotalLoad.Month;