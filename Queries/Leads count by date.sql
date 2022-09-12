/****** Script for SelectTopNRows command from SSMS  ******/
SELECT dealerId, COUNT(dealerId) as leadCount
  FROM [dbo].[LeadInfo]
where DateReceived >= '2021-03-01 00:00:00' and DateReceived < '2022-04-01 00:00:00'
group by dealerId
