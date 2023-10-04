--# cleaning data with sql queries

select *
from [Portofolio Project].dbo.[Neshvile housing]

--standerdize date format

select saledate,convert(date,saledate)as converteddate from [Portofolio Project].dbo.[Neshvile housing]

update  [Portofolio Project].dbo.[Neshvile housing]
set converteddate  = convert(date,saledate)

alter table [Portofolio Project].dbo.[Neshvile housing] add converteddate date;


--populate property adress

select PropertyAddress from  [Portofolio Project].dbo.[Neshvile housing]

select * from [Portofolio Project].dbo.[Neshvile housing]
order by ParcelID


--breking adress into individual columns (city,pin,street)

select PropertyAddress from[Portofolio Project].dbo.[Neshvile housing]

select
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address

,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress)) as  Address

from [Portofolio Project].dbo.[Neshvile housing]

alter table [Portofolio Project].dbo.[Neshvile housing] add propertysplitadress varchar(100);
alter table [Portofolio Project].dbo.[Neshvile housing] add propertysplitcity varchar(100);

select * from [Portofolio Project].dbo.[Neshvile housing]

update [Portofolio Project].dbo.[Neshvile housing] set propertysplitadress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

update [Portofolio Project].dbo.[Neshvile housing] set propertysplitcity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,len(PropertyAddress))

select OwnerName from  [Portofolio Project].dbo.[Neshvile housing]

select
parsename(replace(Ownername,'&','.'),1)
from [Portofolio Project].dbo.[Neshvile housing]


---updating SoldAsvacant with 'Yes' and 'no' where SOldAsVacant is equal tp 'Y', 'N'

select SoldAsVacant from [Portofolio Project].dbo.[Neshvile housing]

select distinct (SoldAsvacant),count(SoldAsVAcant)
from [Portofolio Project].dbo.[Neshvile housing]
group by SoldAsvacant

update [Portofolio Project].dbo.[Neshvile housing]
set SoldAsvacant = case when SoldAsVacant = 'N' then 'NO'
                   when SoldAsVacant = 'Y' then 'Yes'
				   else SoldAsVacant
				   end


--removing duplicates

select * from [Portofolio Project].dbo.[Neshvile housing]


with row_numCTE as (
select *,
     ROW_NUMBER()over(
	 partition by ParcelID,
	              PropertyAddress,
				  SaleDate,
				  LandUse,
				  SalePrice,
				  LegalReference	
		order by UniqueID)row_num
from [Portofolio Project].dbo.[Neshvile housing]
)
delete from row_numCTE
where row_num > 1

--removing unused columns

select * from [Portofolio Project].dbo.[Neshvile housing]
order by converteddate asc
select * from [Portofolio Project].dbo.[Neshvile housing]

alter table [Portofolio Project].dbo.[Neshvile housing]
drop column SaleDate,PropertyAddress,OwnerName,OwnerAddress,TaxDistrict

select * from [Portofolio Project].dbo.[Neshvile housing]
order by converteddate asc