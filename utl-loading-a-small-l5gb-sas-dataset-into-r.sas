%let pgm=utl-loading-a-small-l5gb-sas-dataset-into-r;

Loading a small 15gb sas dataset into r

github
https://tinyurl.com/2p8s887d
https://github.com/rogerjdeangelis/utl-loading-a-small-l5gb-sas-dataset-into-r

Stackoverflow
https://tinyurl.com/2p9f29a5
https://stackoverflow.com/questions/70838634/importing-huge-sas-database-to-rstudio

Big data is a single table over 1tb?
Big execution is over 1000 parallel processes or
    extremely long simulations(over a week)?

Othrwis use a power workstattion.

   Here are two ways to deal with this problem (on my $600 system)

         1. Make sure you have enough memory
            I was able to load the data into R in 13 minutes
            read_sas('f:/sd1/s&c..sas7bdat')
         2. Partition the data
            I was able to load the data into R in 42 seconds


%inc "c:/oto/utl_submit_r64.sas";

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

* Create 15gb file and 20 partitions of the 15gb (s1.sas7bdat-s20.sas7bdat)

%array(_c,values=1-20);

libname msd1 "m:/sd1";
libname fsd1 "f:/sd1";

* create one copy;
* copy to s1-c20 to create partitions;

data sd1.s0;
  set sashelp.class(obs=1);
  do rec=1 to 20000000;
     output;
  end;
  drop rec;
run;quit;

%do_over(_c,phrase=%str(data fsd1.s?; set msd1.s0;run;quit;));

* append all 20 for 15gb table;
data fsd1.sall; set  %do_over(_c,phrase= msd1.s0 ); run;quit;

/*                   _     _ ____        _
(_)_ __  _ __  _   _| |_  / | ___|  __ _| |__
| | `_ \| `_ \| | | | __| | |___ \ / _` | `_ \
| | | | | |_) | |_| | |_  | |___) | (_| | |_) |
|_|_| |_| .__/ \__,_|\__| |_|____/ \__, |_.__/
        |_|                        |___/
*/
Data Set Name        F:/sd1/sall.sas7bdat
Member Type          DATA
Engine               V9
Created              02/02/2022 06:45:28
Observations          400000000
Variables             5

File Size                   15GB
File Size (bytes)           16062873600

 Variables in Creation Order

#    Variable    Type    Len

1    NAME        Char      8
2    SEX         Char      1
3    AGE         Num       8
4    HEIGHT      Num       8
5    WEIGHT      Num       8

/*                   _     ____   ___          _
(_)_ __  _ __  _   _| |_  |___ \ / _ \   _ __ (_) ___  ___ ___  ___
| | `_ \| `_ \| | | | __|   __) | | | | | `_ \| |/ _ \/ __/ _ \/ __|
| | | | | |_) | |_| | |_   / __/| |_| | | |_) | |  __/ (_|  __/\__ \
|_|_| |_| .__/ \__,_|\__| |_____|\___/  | .__/|_|\___|\___\___||___/
        |_|                             |_|
*/

  F:\SD1
    s1.sas7bdat
    s2.sas7bdat
    s3.sas7bdat
    s4.sas7bdat
    s5.sas7bdat
    s6.sas7bdat
    s7.sas7bdat
    s8.sas7bdat
    s9.sas7bdat
    s10.sas7bdat
    s11.sas7bdat
    s12.sas7bdat
    s13.sas7bdat
    s14.sas7bdat
    s15.sas7bdat
    s16.sas7bdat
    s17.sas7bdat
    s18.sas7bdat
    s19.sas7bdat
    s20.sas7bdat

/*           _               _     _ ____        _
  ___  _   _| |_ _ __  _   _| |_  / | ___|  __ _| |__
 / _ \| | | | __| `_ \| | | | __| | |___ \ / _` | `_ \
| (_) | |_| | |_| |_) | |_| | |_  | |___) | (_| | |_) |
 \___/ \__,_|\__| .__/ \__,_|\__| |_|____/ \__, |_.__/
                |_|                        |___/
*/

> library(haven);sall <-read_sas('f:/sd1/s1.sas7bdat');str(sall)
tibble [400,000,000 x 5] (S3: tbl_df/tbl/data.frame)
 $ NAME  : chr [1:20000000] "Alfred" "Alfred" "Alfred" "Alfred" ...
 $ SEX   : chr [1:20000000] "M" "M" "M" "M" ...
 $ AGE   : num [1:20000000] 14 14 14 14 14 14 14 14 14 14 ...
 $ HEIGHT: num [1:20000000] 69 69 69 69 69 69 69 69 69 69 ...
 $ WEIGHT: num [1:20000000] 112 112 112 112 112 ...
>

/*           _               _                               __   ____   ___
  ___  _   _| |_ _ __  _   _| |_    ___  _ __   ___    ___  / _| |___ \ / _ \
 / _ \| | | | __| `_ \| | | | __|  / _ \| `_ \ / _ \  / _ \| |_    __) | | | |
| (_) | |_| | |_| |_) | |_| | |_  | (_) | | | |  __/ | (_) |  _|  / __/| |_| |
 \___/ \__,_|\__| .__/ \__,_|\__|  \___/|_| |_|\___|  \___/|_|   |_____|\___/
                |_|
*/

> library(haven);s1 <-read_sas('f:/sd1/s1.sas7bdat');str(s1)
tibble [20,000,000 x 5] (S3: tbl_df/tbl/data.frame)
 $ NAME  : chr [1:20000000] "Alfred" "Alfred" "Alfred" "Alfred" ...
 $ SEX   : chr [1:20000000] "M" "M" "M" "M" ...
 $ AGE   : num [1:20000000] 14 14 14 14 14 14 14 14 14 14 ...
 $ HEIGHT: num [1:20000000] 69 69 69 69 69 69 69 69 69 69 ...
 $ WEIGHT: num [1:20000000] 112 112 112 112 112 ...
>


/*                                   _ ____        _
 _ __  _ __ ___   ___ ___  ___ ___  / | ___|  __ _| |__
| `_ \| `__/ _ \ / __/ _ \/ __/ __| | |___ \ / _` | `_ \
| |_) | | | (_) | (_|  __/\__ \__ \ | |___) | (_| | |_) |
| .__/|_|  \___/ \___\___||___/___/ |_|____/ \__, |_.__/
|_|                                          |___/
*/

%utl_submit_r64("library(haven);sall <-read_sas('f:/sd1/sall.sas7bdat');str(sall)");

/*                                   ____   ___          _
 _ __  _ __ ___   ___ ___  ___ ___  |___ \ / _ \   _ __ (_) ___  ___ ___  ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|   __) | | | | | `_ \| |/ _ \/ __/ _ \/ __|
| |_) | | | (_) | (_|  __/\__ \__ \  / __/| |_| | | |_) | |  __/ (_|  __/\__ \
| .__/|_|  \___/ \___\___||___/___/ |_____|\___/  | .__/|_|\___|\___\___||___/
|_|                                               |_|
*/

* save macro to autocall library fr easy commad line task;
filename ft15f001 "c:/oto/cnk.sas";
parmcards4;
%macro cnk(c);
     %utl_submit_r64("library(haven);s&c <-read_sas('f:/sd1/s&c..sas7bdat');str(s&c)");
%mend cnk;
;;;;
run;quit;

%inc "c:/oto/cnk.sas";

* test intractively;
%cnk(1);

* run in parallel;


%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin c:\nul
 -sasautos c:\oto -work d:\wrk -nosplash -rsasuser));

options noxwait noxsync;
%let tym=%sysfunc(time());
systask kill sys1 sys2 sys3 sys4  sys5 sys6 sys7 sys8 sys9 sys10
             sys11 sys12 sys13 sys14  sys15 sys16 sys17 sys18 sys19 sys20 ;
systask command "&_s -termstmt %nrstr(%cnk(1);) -log d:\log\a1.log" taskname=sys1;
systask command "&_s -termstmt %nrstr(%cnk(2);) -log d:\log\a2.log" taskname=sys2;
systask command "&_s -termstmt %nrstr(%cnk(3);) -log d:\log\a3.log" taskname=sys3;
systask command "&_s -termstmt %nrstr(%cnk(4);) -log d:\log\a4.log" taskname=sys4;
systask command "&_s -termstmt %nrstr(%cnk(5);) -log d:\log\a5.log" taskname=sys5;
systask command "&_s -termstmt %nrstr(%cnk(6);) -log d:\log\a6.log" taskname=sys6;
systask command "&_s -termstmt %nrstr(%cnk(7);) -log d:\log\a7.log" taskname=sys7;
systask command "&_s -termstmt %nrstr(%cnk(8);) -log d:\log\a8.log" taskname=sys8;
systask command "&_s -termstmt %nrstr(%cnk(9);) -log d:\log\a9.log" taskname=sys9;
systask command "&_s -termstmt %nrstr(%cnk(10);) -log d:\log\a10.log" taskname=sys10;
systask command "&_s -termstmt %nrstr(%cnk(11);) -log d:\log\a11.log" taskname=sys11;
systask command "&_s -termstmt %nrstr(%cnk(12);) -log d:\log\a12.log" taskname=sys12;
systask command "&_s -termstmt %nrstr(%cnk(13);) -log d:\log\a13.log" taskname=sys13;
systask command "&_s -termstmt %nrstr(%cnk(14);) -log d:\log\a14.log" taskname=sys14;
systask command "&_s -termstmt %nrstr(%cnk(15);) -log d:\log\a15.log" taskname=sys15;
systask command "&_s -termstmt %nrstr(%cnk(16);) -log d:\log\a16.log" taskname=sys16;
systask command "&_s -termstmt %nrstr(%cnk(17);) -log d:\log\a17.log" taskname=sys17;
systask command "&_s -termstmt %nrstr(%cnk(18);) -log d:\log\a18.log" taskname=sys18;
systask command "&_s -termstmt %nrstr(%cnk(19);) -log d:\log\a19.log" taskname=sys19;
systask command "&_s -termstmt %nrstr(%cnk(20);) -log d:\log\a20.log" taskname=sys20;
waitfor sys1 sys2 sys3 sys4  sys5 sys6 sys7 sys8 sys9 sys10
        sys11 sys12 sys13 sys14  sys15 sys16 sys17 sys18 sys19 sys20 ;
%let secs=%sysevalf(%sysfunc(time()) - &tym);
%put &=secs;
43 seconds

/*               _
 ___  __ _ ___  | | ___   __ _
/ __|/ _` / __| | |/ _ \ / _` |
\__ \ (_| \__ \ | | (_) | (_| |
|___/\__,_|___/ |_|\___/ \__, |
                         |___/
*/

* d:/log/a1.log ;

library(haven);s20 <-read_sas('f:/sd1/s20.sas7bdat');str(s20)

NOTE: 1 record was written to the file R_PGM.
      The minimum record length was 61.
      The maximum record length was 61.
NOTE: DATA statement used (Total process time):
      real time           0.04 seconds
      cpu time            0.01 seconds



NOTE: The infile RUT is:
      Unnamed Pipe Access Device,
      PROCESS=D:\r412\R\R-4.1.2\bin\R.exe --vanilla --quiet --no-save < d:\wrk\_TD7300_T7610_\r_pgm.txt,
      RECFM=V,LRECL=32756

> library(haven);s20 <-read_sas('f:/sd1/s20.sas7bdat');str(s20)
tibble [20,000,000 x 5] (S3: tbl_df/tbl/data.frame)
 $ NAME  : chr [1:20000000] "Alfred" "Alfred" "Alfred" "Alfred" ...
 $ SEX   : chr [1:20000000] "M" "M" "M" "M" ...
 $ AGE   : num [1:20000000] 14 14 14 14 14 14 14 14 14 14 ...
 $ HEIGHT: num [1:20000000] 69 69 69 69 69 69 69 69 69 69 ...
 $ WEIGHT: num [1:20000000] 112 112 112 112 112 ...
>
NOTE: 8 lines were written to file PRINT.
NOTE: 8 records were read from the infile RUT.
      The minimum record length was 2.
      The maximum record length was 67.
NOTE: The DATA step printed page 1.
NOTE: DATA statement used (Total process time):
      real time           41.76 seconds
      cpu time            0.04 seconds


2        The SAS System           19:34 Tuesday, February 1, 2022


NOTE: Fileref RUT has been deassigned.
NOTE: Fileref R_PGM has been deassigned.

NOTE: SAS Institute Inc., SAS Campus Drive, Cary, NC USA 27513-2414
NOTE: The SAS System used:
      real time           43.20 seconds
      cpu time            0.21 seconds
