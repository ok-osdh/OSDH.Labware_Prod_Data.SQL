﻿CREATE ROLE [db_executor]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [db_executor] ADD MEMBER [phocisapp];

