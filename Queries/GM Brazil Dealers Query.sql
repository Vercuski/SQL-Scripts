select  * from dealeron..DealerOemProgram dop
inner join dealeron..Dealeron_Setup ds on ds.dealer_id = dop.dealerId
where ds.status = 1 and dop.OemProgram = 'GM Brazil' and livedate is not null