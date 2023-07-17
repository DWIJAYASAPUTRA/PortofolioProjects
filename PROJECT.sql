SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [cleaning].[dbo].[cleaning];
  -- cleaning data in SQL Queries
  SELECT * 
  FROM CLEANING.DBO.CLEANING;

  -- Standardize date format
  SELECT SaleDateConverted, CONVERT(DATE,SALEDATE)
  FROM CLEANING.DBO.CLEANING;

  UPDATE CLEANING
  SET SaleDate =  CONVERT(DATE,SALEDATE)

  ALTER TABLE CLEANING
  Add SaleDateConverted DATE;

  UPDATE CLEANING
  SET SaleDateConverted =  CONVERT(DATE,SALEDATE)

  -- populate property address data
   SELECT *
  FROM CLEANING.DBO.CLEANING
  -- WHERE PropertyAddress is NULL
  ORDER BY ParcelID

  SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
  FROM CLEANING.DBO.CLEANING a
  JOIN CLEANING.DBO.CLEANING b
  on a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <> b.[UniqueID ]
  WHERE a.PropertyAddress is NULL

  UPDATE a
  SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
  FROM CLEANING.DBO.CLEANING a
  JOIN CLEANING.DBO.CLEANING b
  on a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <> b.[UniqueID ]
   WHERE a.PropertyAddress is NULL

   -- Breaking out address into individual column (address, city, state)
   SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
   SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN (PropertyAddress)) AS Address
   FROM CLEANING.DBO.CLEANING

   ALTER TABLE CLEANING
  Add PropertyAddressSplit NVARCHAR(255);

  UPDATE CLEANING
  SET PropertyAddressSplit =  SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

  ALTER TABLE CLEANING
  Add PropertyAddressCity NVARCHAR(255);

  UPDATE CLEANING
  SET PropertyAddressCity =  SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN (PropertyAddress))

  SELECT *
    FROM CLEANING.DBO.CLEANING



SELECT 
PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 3),
PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 2),
PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 1)
    FROM CLEANING.DBO.CLEANING

   ALTER TABLE CLEANING
  Add OwnerAddressSplit NVARCHAR(255);

  UPDATE CLEANING
  SET OwnerAddressSplit =  PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 3)

  ALTER TABLE CLEANING
  Add OwnerAddressCity NVARCHAR(255);

  UPDATE CLEANING
  SET OwnerAddressCity =  PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 2)

  ALTER TABLE CLEANING
  Add OwnerAddressState NVARCHAR(255);

  UPDATE CLEANING
  SET OwnerAddressState =  PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 1)

    SELECT *
    FROM CLEANING.DBO.CLEANING

-- CHANGE Y AND N TO YES AND NO IN SOLDASVACANT
SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
FROM CLEANING.DBO.CLEANING


UPDATE CLEANING
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
FROM CLEANING.DBO.CLEANING

SELECT DISTINCT(SOLDASVACANT)
FROM CLEANING.DBO.CLEANING


-- REMOVE DUPLICATES

WITH RowNumCTE AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY PARCELID,
			 PROPERTYADDRESS,
			 SALEPRICE,
			 SALEDATE,
			 LEGALREFERENCE
			 ORDER BY 
			 UNIQUEID
			 ) ROW_NUM
FROM CLEANING.DBO.CLEANING)
SELECT *
FROM RowNumCTE
WHERE ROW_NUM > 1
ORDER BY PROPERTYADDRESS


-- DELETE UNUSED COLUMN
    SELECT *
    FROM CLEANING.DBO.CLEANING

ALTER TABLE CLEANING.DBO.CLEANING
DROP COLUMN PROPERTYADDRESS, OWNERADDRESS, TAXDISTRICT, LANDUSE