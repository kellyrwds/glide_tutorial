/*Declare SAS-Teradata Connection*/
%let SYS_PROJECT=rwds_[project number];
%let SYS_GROUP=RWDS;
%let SYS_DATALAB=RWDS_RWDS_[project number];
%let SYS_USERLAB=RWDS_[user];

/*This one is to connect to EU teradata box*/
LIBNAME dbc TERADATA SERVER=tdb SCHEMA=DBC AUTHDOMAIN=TeradataAuth
query_band="SYS_PROJECT=&sys_project.;SYS_GROUP=&sys_group.;";
LIBNAME dhpublic TERADATA SERVER=tdb SCHEMA=DATAHUB_public AUTHDOMAIN=TeradataAuth
query_band="SYS_PROJECT=&sys_project.;SYS_GROUP=&sys_group.;";
LIBNAME _tdwork TERADATA SERVER=tdb AUTHDOMAIN=TeradataAuth MODE=teradata
   	DBMSTEMP=yes CONNECTION=global
query_band="SYS_PROJECT=&sys_project.;SYS_GROUP=&sys_group.;";
libname _DATALAB TERADATA server=tdb schema=&SYS_DATALAB AUTHDOMAIN=teradataauth
query_band="SYS_PROJECT=&sys_project.;SYS_GROUP=&sys_group.;";

/*Macro to connect to EU teradata global area via PROC SQL Explicit pass through*/
%macro connectgl;
   connect to teradata (server=tdb mode=teradata connection=global
        AUTHDOMAIN=TeradataAuth
query_band="SYS_PROJECT=&sys_project.;SYS_GROUP=&sys_group.;");
%mend connectgl;
