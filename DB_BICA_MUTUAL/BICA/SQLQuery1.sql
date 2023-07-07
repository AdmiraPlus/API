use BICAMutual
select * from userapi
select * from ClientCredentials

select * from AMVMovimientos

SELECT  u.username, u. full_name, u.email, u.disabled, u.password, c.client_id, c.client_secret
	FROM UserAPI u
	JOIN ClientCredentials c
		ON u.credentials_id = c.id;
