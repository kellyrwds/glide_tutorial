/*Query data*/
proc sql;
%connectgl;
select * from connection to teradata(
select * from [teradata table]
sample 100
);
quit;

/*Create volatile table*/
%droptd(table_name);
proc sql;
%connectgl;
execute(create volatile multiset table table_name as (
[insert your select statement]
) with data on commit preserve rows;
) by teradata;
quit;



/*Creating a volatile table - Redbook Example*/
%droptd(cyclosporin);
proc sql;
%connectgl;
execute(create volatile multiset table cyclosporin as (
select distinct gennme,prodnme from RWD_VDM_REDBOOK.REDBOOK
where upper(gennme) like ('%CYCLOSPORIN%')
) with data on commit preserve rows;
) by teradata;
quit;


/*See the data - implicit sas*/
proc print data=_tdwork.cyclosporin;
title 'CYCLOSPORIN';
run;

/*See the data - explicit sas*/
proc sql;
%connectgl;
select * from connection to teradata (
select * from cyclosporin
);
quit;


/*Create permanent table*/
%%droplab(table_name);
proc sql;
%connectgl;
execute(create table &sys_datalab..table_name as (
[insert your select statement]
) with data;
) by teradata;
quit;


/*Creating a permanent table - example*/

%droplab(cyclosporin);
proc sql;
%connectgl;
execute(create table &sys_datalab..cyclosporin as (
select distinct gennme,prodnme from RWD_VDM_REDBOOK.REDBOOK
where upper(gennme) like ('%CYCLOSPORIN%')
) with data;
) by teradata;
quit;
