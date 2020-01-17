SELECT '' AS Source, '' AS Datasate, AreaName, AreaTypeCodeText, MapCodeText, ResolutionCodeText, Year, Month, Day, DateTime, TotalLoadValue, UpdateTime 
FROM ActualTotalLoad, ResolutionCode, AreaTypeCode, MapCode
WHERE AreaName='Greece' AND ResolutionCodeText='PT60M' AND ResolutionCode.Id = ResolutionCodeId AND MapCode.Id=MapCodeId AND AreaTypeCode.Id=AreaTypeCodeId;