SELECT '' AS Source, '' AS Dataset, AreaName, AreaTypeCodeText, MapCodeText, ResolutionCodeText,Year, Month, SUM(TotalLoadValue) AS ActualTotalLoadByDateValue
FROM ActualTotalLoad, ResolutionCode, AreaTypeCode, MapCode
WHERE AreaName='Greece' AND ResolutionCodeText='PT60M' AND ResolutionCode.Id = ResolutionCodeId AND MapCode.Id=MapCodeId AND AreaTypeCode.Id=AreaTypeCodeId AND ResolutionCodeId=2 AND Year=2018;