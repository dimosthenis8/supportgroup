SELECT '' AS Source, '' AS Dataset, AreaName, AreaTypeCodeText, MapCodeText, ResolutionCodeText, Year, Month, Day, SUM(TotalLoadValue) AS ActualTotalLoadByDateValue
FROM ActualTotalLoad, ResolutionCode, AreaTypeCode, MapCode
WHERE AreaName='Greece' AND ResolutionCodeText='PT6OM' AND ResolutionCode.Id = ResolutionCodeId AND MapCode.Id=MapCodeId AND AreaTypeCode.Id=AreaTypeCodeId AND ResolutionCodeId=2 AND Year=2018 AND Month=1;
