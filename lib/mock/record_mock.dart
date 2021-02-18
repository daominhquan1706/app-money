const String fakeDataWallet = """
[{
  "id": 1,
  "name": "Rosabelle",
  "created_date": "7/11/2020",
  "modified_date": "2/20/2020"
}, {
  "id": 2,
  "name": "Beryl",
  "created_date": "12/19/2020",
  "modified_date": "5/19/2020"
}, {
  "id": 3,
  "name": "Teresita",
  "created_date": "6/7/2020",
  "modified_date": "9/17/2020"
}, {
  "id": 4,
  "name": "Way",
  "created_date": "8/4/2020",
  "modified_date": "5/31/2020"
}, {
  "id": 5,
  "name": "Roobbie",
  "created_date": "1/21/2021",
  "modified_date": "3/14/2020"
}]
""";
const String fakeDataRecords = """
[{
  "id": 1,
  "createDate": "10/30/2020",
  "title": "Del Castello",
  "note": "sdelcastello0@sphinn.com",
  "amount": 812108,
  "wallet_id": 4
}, {
  "id": 2,
  "createDate": "8/28/2020",
  "title": "Raatz",
  "note": "iraatz1@skype.com",
  "amount": -672862,
  "wallet_id": 4
}, {
  "id": 3,
  "createDate": "4/4/2020",
  "title": "Espinha",
  "note": "despinha2@hibu.com",
  "amount": 610154,
  "wallet_id": 4
}, {
  "id": 4,
  "createDate": "6/1/2020",
  "title": "Lerohan",
  "note": "clerohan3@harvard.edu",
  "amount": -739854,
  "wallet_id": 1
}, {
  "id": 5,
  "createDate": "6/25/2020",
  "title": "Emmison",
  "note": "cemmison4@businessinsider.com",
  "amount": 651284,
  "wallet_id": 5
}, {
  "id": 6,
  "createDate": "2/20/2020",
  "title": "Golland",
  "note": "ngolland5@liveinternet.ru",
  "amount": 653375,
  "wallet_id": 1
}, {
  "id": 7,
  "createDate": "8/28/2020",
  "title": "Benettini",
  "note": "ebenettini6@eventbrite.com",
  "amount": -552867,
  "wallet_id": 2
}, {
  "id": 8,
  "createDate": "1/25/2021",
  "title": "Whyborn",
  "note": "cwhyborn7@hp.com",
  "amount": 318458,
  "wallet_id": 5
}, {
  "id": 9,
  "createDate": "3/8/2020",
  "title": "Greenslade",
  "note": "mgreenslade8@mit.edu",
  "amount": -813094,
  "wallet_id": 3
}, {
  "id": 10,
  "createDate": "6/5/2020",
  "title": "Tresise",
  "note": "dtresise9@addthis.com",
  "amount": 384323,
  "wallet_id": 5
}, {
  "id": 11,
  "createDate": "1/16/2021",
  "title": "Dudenie",
  "note": "gdudeniea@scientificamerican.com",
  "amount": -612430,
  "wallet_id": 4
}, {
  "id": 12,
  "createDate": "11/8/2020",
  "title": "Montford",
  "note": "jmontfordb@is.gd",
  "amount": 604511,
  "wallet_id": 2
}, {
  "id": 13,
  "createDate": "5/12/2020",
  "title": "Beaves",
  "note": "dbeavesc@php.net",
  "amount": -928171,
  "wallet_id": 5
}, {
  "id": 14,
  "createDate": "10/23/2020",
  "title": "Basten",
  "note": "kbastend@t-online.de",
  "amount": 189954,
  "wallet_id": 1
}, {
  "id": 15,
  "createDate": "1/23/2021",
  "title": "Cottey",
  "note": "wcotteye@princeton.edu",
  "amount": 163245,
  "wallet_id": 2
}, {
  "id": 16,
  "createDate": "10/10/2020",
  "title": "Burgwyn",
  "note": "wburgwynf@list-manage.com",
  "amount": -495960,
  "wallet_id": 4
}, {
  "id": 17,
  "createDate": "1/23/2021",
  "title": "Brotheridge",
  "note": "gbrotheridgeg@mtv.com",
  "amount": 200260,
  "wallet_id": 4
}, {
  "id": 18,
  "createDate": "7/29/2020",
  "title": "Sidden",
  "note": "tsiddenh@liveinternet.ru",
  "amount": -889206,
  "wallet_id": 5
}, {
  "id": 19,
  "createDate": "2/18/2020",
  "title": "Capper",
  "note": "vcapperi@yale.edu",
  "amount": -585375,
  "wallet_id": 2
}, {
  "id": 20,
  "createDate": "6/6/2020",
  "title": "Latek",
  "note": "platekj@sohu.com",
  "amount": -995602,
  "wallet_id": 5
}, {
  "id": 21,
  "createDate": "8/14/2020",
  "title": "Ferdinand",
  "note": "bferdinandk@amazon.co.uk",
  "amount": -119191,
  "wallet_id": 2
}, {
  "id": 22,
  "createDate": "2/6/2020",
  "title": "Godson",
  "note": "jgodsonl@theatlantic.com",
  "amount": 407975,
  "wallet_id": 2
}, {
  "id": 23,
  "createDate": "3/24/2020",
  "title": "Abramski",
  "note": "sabramskim@wiley.com",
  "amount": -570520,
  "wallet_id": 5
}, {
  "id": 24,
  "createDate": "5/24/2020",
  "title": "MacShane",
  "note": "rmacshanen@bravesites.com",
  "amount": -887880,
  "wallet_id": 2
}, {
  "id": 25,
  "createDate": "12/19/2020",
  "title": "Brummell",
  "note": "tbrummello@forbes.com",
  "amount": -566679,
  "wallet_id": 5
}, {
  "id": 26,
  "createDate": "6/28/2020",
  "title": "Lapthorne",
  "note": "clapthornep@utexas.edu",
  "amount": -599950,
  "wallet_id": 2
}, {
  "id": 27,
  "createDate": "11/29/2020",
  "title": "Wombwell",
  "note": "vwombwellq@typepad.com",
  "amount": 141203,
  "wallet_id": 2
}, {
  "id": 28,
  "createDate": "11/14/2020",
  "title": "Garlicke",
  "note": "mgarlicker@statcounter.com",
  "amount": 902890,
  "wallet_id": 1
}, {
  "id": 29,
  "createDate": "3/29/2020",
  "title": "Ellesworthe",
  "note": "sellesworthes@woothemes.com",
  "amount": -400389,
  "wallet_id": 2
}, {
  "id": 30,
  "createDate": "11/12/2020",
  "title": "Tumioto",
  "note": "ftumiotot@shinystat.com",
  "amount": 716072,
  "wallet_id": 2
}, {
  "id": 31,
  "createDate": "1/4/2021",
  "title": "Levicount",
  "note": "elevicountu@fastcompany.com",
  "amount": -677002,
  "wallet_id": 2
}, {
  "id": 32,
  "createDate": "11/8/2020",
  "title": "Gorner",
  "note": "jgornerv@free.fr",
  "amount": 672943,
  "wallet_id": 4
}, {
  "id": 33,
  "createDate": "6/17/2020",
  "title": "Buckston",
  "note": "dbuckstonw@theatlantic.com",
  "amount": 946700,
  "wallet_id": 1
}, {
  "id": 34,
  "createDate": "5/1/2020",
  "title": "Mournian",
  "note": "tmournianx@ezinearticles.com",
  "amount": -705166,
  "wallet_id": 4
}, {
  "id": 35,
  "createDate": "8/20/2020",
  "title": "Sabati",
  "note": "csabatiy@geocities.jp",
  "amount": 626298,
  "wallet_id": 5
}, {
  "id": 36,
  "createDate": "8/6/2020",
  "title": "Razzell",
  "note": "hrazzellz@nbcnews.com",
  "amount": 221540,
  "wallet_id": 1
}, {
  "id": 37,
  "createDate": "6/10/2020",
  "title": "Beswetherick",
  "note": "abeswetherick10@issuu.com",
  "amount": 384124,
  "wallet_id": 2
}, {
  "id": 38,
  "createDate": "1/6/2021",
  "title": "Gell",
  "note": "cgell11@opera.com",
  "amount": -501072,
  "wallet_id": 4
}, {
  "id": 39,
  "createDate": "11/22/2020",
  "title": "Pedgrift",
  "note": "vpedgrift12@youtube.com",
  "amount": 259322,
  "wallet_id": 2
}, {
  "id": 40,
  "createDate": "10/16/2020",
  "title": "Casol",
  "note": "qcasol13@vistaprint.com",
  "amount": 548526,
  "wallet_id": 4
}, {
  "id": 41,
  "createDate": "3/21/2020",
  "title": "MacColm",
  "note": "amaccolm14@google.pl",
  "amount": 606783,
  "wallet_id": 3
}, {
  "id": 42,
  "createDate": "12/27/2020",
  "title": "Saffe",
  "note": "asaffe15@ucsd.edu",
  "amount": 949188,
  "wallet_id": 4
}, {
  "id": 43,
  "createDate": "2/4/2020",
  "title": "Yielding",
  "note": "lyielding16@elegantthemes.com",
  "amount": -783994,
  "wallet_id": 3
}, {
  "id": 44,
  "createDate": "6/4/2020",
  "title": "Ghirardi",
  "note": "hghirardi17@ovh.net",
  "amount": -975609,
  "wallet_id": 1
}, {
  "id": 45,
  "createDate": "8/10/2020",
  "title": "Munnis",
  "note": "emunnis18@timesonline.co.uk",
  "amount": 634678,
  "wallet_id": 5
}, {
  "id": 46,
  "createDate": "8/3/2020",
  "title": "Hourstan",
  "note": "ihourstan19@unicef.org",
  "amount": 727302,
  "wallet_id": 3
}, {
  "id": 47,
  "createDate": "2/7/2020",
  "title": "Dickerson",
  "note": "ddickerson1a@ifeng.com",
  "amount": -394115,
  "wallet_id": 2
}, {
  "id": 48,
  "createDate": "10/5/2020",
  "title": "O'Hoolahan",
  "note": "bohoolahan1b@guardian.co.uk",
  "amount": -315464,
  "wallet_id": 5
}, {
  "id": 49,
  "createDate": "8/30/2020",
  "title": "O'Henehan",
  "note": "bohenehan1c@goo.gl",
  "amount": -616906,
  "wallet_id": 5
}, {
  "id": 50,
  "createDate": "3/10/2020",
  "title": "Pfaff",
  "note": "jpfaff1d@ezinearticles.com",
  "amount": -533480,
  "wallet_id": 1
}, {
  "id": 51,
  "createDate": "6/20/2020",
  "title": "Ramiro",
  "note": "rramiro1e@163.com",
  "amount": 21239,
  "wallet_id": 4
}, {
  "id": 52,
  "createDate": "5/25/2020",
  "title": "Widdowfield",
  "note": "ewiddowfield1f@oaic.gov.au",
  "amount": 693376,
  "wallet_id": 2
}, {
  "id": 53,
  "createDate": "4/26/2020",
  "title": "Mingardo",
  "note": "hmingardo1g@fotki.com",
  "amount": 840904,
  "wallet_id": 4
}, {
  "id": 54,
  "createDate": "9/3/2020",
  "title": "Fullerlove",
  "note": "afullerlove1h@etsy.com",
  "amount": 294562,
  "wallet_id": 5
}, {
  "id": 55,
  "createDate": "3/3/2020",
  "title": "Goldby",
  "note": "pgoldby1i@google.nl",
  "amount": 532966,
  "wallet_id": 1
}, {
  "id": 56,
  "createDate": "6/28/2020",
  "title": "Dumbrill",
  "note": "idumbrill1j@skyrock.com",
  "amount": 393235,
  "wallet_id": 2
}, {
  "id": 57,
  "createDate": "3/1/2020",
  "title": "MacGilfoyle",
  "note": "lmacgilfoyle1k@samsung.com",
  "amount": 308712,
  "wallet_id": 1
}, {
  "id": 58,
  "createDate": "5/13/2020",
  "title": "Beasant",
  "note": "bbeasant1l@prnewswire.com",
  "amount": -727945,
  "wallet_id": 1
}, {
  "id": 59,
  "createDate": "4/1/2020",
  "title": "Smooth",
  "note": "asmooth1m@freewebs.com",
  "amount": -184982,
  "wallet_id": 5
}, {
  "id": 60,
  "createDate": "4/5/2020",
  "title": "Rabat",
  "note": "prabat1n@scribd.com",
  "amount": 222141,
  "wallet_id": 1
}, {
  "id": 61,
  "createDate": "2/11/2020",
  "title": "Fonte",
  "note": "nfonte1o@naver.com",
  "amount": 705045,
  "wallet_id": 3
}, {
  "id": 62,
  "createDate": "11/24/2020",
  "title": "Chuter",
  "note": "nchuter1p@columbia.edu",
  "amount": 955526,
  "wallet_id": 4
}, {
  "id": 63,
  "createDate": "10/8/2020",
  "title": "Jillions",
  "note": "cjillions1q@google.com.br",
  "amount": 171723,
  "wallet_id": 3
}, {
  "id": 64,
  "createDate": "10/14/2020",
  "title": "Costard",
  "note": "lcostard1r@storify.com",
  "amount": 540317,
  "wallet_id": 3
}, {
  "id": 65,
  "createDate": "4/1/2020",
  "title": "Floodgate",
  "note": "pfloodgate1s@twitpic.com",
  "amount": 377726,
  "wallet_id": 1
}, {
  "id": 66,
  "createDate": "7/30/2020",
  "title": "Bunner",
  "note": "sbunner1t@nhs.uk",
  "amount": 878562,
  "wallet_id": 4
}, {
  "id": 67,
  "createDate": "9/12/2020",
  "title": "Gascoyen",
  "note": "rgascoyen1u@scientificamerican.com",
  "amount": -630666,
  "wallet_id": 4
}, {
  "id": 68,
  "createDate": "1/8/2021",
  "title": "Megainey",
  "note": "gmegainey1v@meetup.com",
  "amount": 587809,
  "wallet_id": 1
}, {
  "id": 69,
  "createDate": "1/3/2021",
  "title": "Blagbrough",
  "note": "sblagbrough1w@princeton.edu",
  "amount": -642443,
  "wallet_id": 4
}, {
  "id": 70,
  "createDate": "10/9/2020",
  "title": "McAline",
  "note": "emcaline1x@chron.com",
  "amount": -955521,
  "wallet_id": 3
}, {
  "id": 71,
  "createDate": "11/12/2020",
  "title": "Tunny",
  "note": "atunny1y@sogou.com",
  "amount": 996636,
  "wallet_id": 3
}, {
  "id": 72,
  "createDate": "7/18/2020",
  "title": "Rosendale",
  "note": "wrosendale1z@bing.com",
  "amount": 79769,
  "wallet_id": 4
}, {
  "id": 73,
  "createDate": "10/17/2020",
  "title": "Binton",
  "note": "hbinton20@usda.gov",
  "amount": -49939,
  "wallet_id": 4
}, {
  "id": 74,
  "createDate": "10/25/2020",
  "title": "Morando",
  "note": "tmorando21@jiathis.com",
  "amount": 609547,
  "wallet_id": 1
}, {
  "id": 75,
  "createDate": "7/7/2020",
  "title": "Hamfleet",
  "note": "chamfleet22@phoca.cz",
  "amount": 432159,
  "wallet_id": 2
}, {
  "id": 76,
  "createDate": "9/16/2020",
  "title": "Tellenbrok",
  "note": "dtellenbrok23@si.edu",
  "amount": -316679,
  "wallet_id": 2
}, {
  "id": 77,
  "createDate": "3/21/2020",
  "title": "Beggio",
  "note": "abeggio24@baidu.com",
  "amount": 135678,
  "wallet_id": 4
}, {
  "id": 78,
  "createDate": "5/25/2020",
  "title": "Simond",
  "note": "csimond25@marketwatch.com",
  "amount": -55,
  "wallet_id": 1
}, {
  "id": 79,
  "createDate": "6/14/2020",
  "title": "Ledur",
  "note": "bledur26@sogou.com",
  "amount": -222030,
  "wallet_id": 2
}, {
  "id": 80,
  "createDate": "11/30/2020",
  "title": "Crumley",
  "note": "fcrumley27@bloglovin.com",
  "amount": -813104,
  "wallet_id": 3
}, {
  "id": 81,
  "createDate": "1/4/2021",
  "title": "Burk",
  "note": "nburk28@symantec.com",
  "amount": -700519,
  "wallet_id": 1
}, {
  "id": 82,
  "createDate": "11/4/2020",
  "title": "Goldbourn",
  "note": "lgoldbourn29@multiply.com",
  "amount": 819757,
  "wallet_id": 5
}, {
  "id": 83,
  "createDate": "2/6/2020",
  "title": "de Guerre",
  "note": "jdeguerre2a@wiley.com",
  "amount": 895672,
  "wallet_id": 3
}, {
  "id": 84,
  "createDate": "3/12/2020",
  "title": "O'Corr",
  "note": "kocorr2b@webmd.com",
  "amount": 48953,
  "wallet_id": 5
}, {
  "id": 85,
  "createDate": "5/31/2020",
  "title": "Congreave",
  "note": "lcongreave2c@digg.com",
  "amount": -147435,
  "wallet_id": 1
}, {
  "id": 86,
  "createDate": "7/12/2020",
  "title": "Acton",
  "note": "bacton2d@i2i.jp",
  "amount": 462313,
  "wallet_id": 4
}, {
  "id": 87,
  "createDate": "10/23/2020",
  "title": "Quogan",
  "note": "vquogan2e@marketwatch.com",
  "amount": -271137,
  "wallet_id": 3
}, {
  "id": 88,
  "createDate": "8/13/2020",
  "title": "Alner",
  "note": "ealner2f@uiuc.edu",
  "amount": -596455,
  "wallet_id": 3
}, {
  "id": 89,
  "createDate": "1/2/2021",
  "title": "Sarl",
  "note": "bsarl2g@exblog.jp",
  "amount": 937045,
  "wallet_id": 4
}, {
  "id": 90,
  "createDate": "6/30/2020",
  "title": "Spawton",
  "note": "mspawton2h@ustream.tv",
  "amount": 736042,
  "wallet_id": 2
}, {
  "id": 91,
  "createDate": "3/31/2020",
  "title": "Kirtlan",
  "note": "mkirtlan2i@issuu.com",
  "amount": 915268,
  "wallet_id": 3
}, {
  "id": 92,
  "createDate": "3/20/2020",
  "title": "Purrington",
  "note": "fpurrington2j@posterous.com",
  "amount": 204421,
  "wallet_id": 1
}, {
  "id": 93,
  "createDate": "1/6/2021",
  "title": "Henric",
  "note": "dhenric2k@diigo.com",
  "amount": -583355,
  "wallet_id": 5
}, {
  "id": 94,
  "createDate": "1/3/2021",
  "title": "Logg",
  "note": "blogg2l@bandcamp.com",
  "amount": -250000,
  "wallet_id": 5
}, {
  "id": 95,
  "createDate": "8/17/2020",
  "title": "Mallinar",
  "note": "cmallinar2m@yolasite.com",
  "amount": -94832,
  "wallet_id": 1
}, {
  "id": 96,
  "createDate": "5/22/2020",
  "title": "Louden",
  "note": "glouden2n@digg.com",
  "amount": 530961,
  "wallet_id": 3
}, {
  "id": 97,
  "createDate": "8/13/2020",
  "title": "Marham",
  "note": "hmarham2o@usa.gov",
  "amount": 183063,
  "wallet_id": 3
}, {
  "id": 98,
  "createDate": "5/7/2020",
  "title": "Greggor",
  "note": "bgreggor2p@google.fr",
  "amount": 711132,
  "wallet_id": 2
}, {
  "id": 99,
  "createDate": "9/28/2020",
  "title": "Hiers",
  "note": "chiers2q@github.com",
  "amount": -934045,
  "wallet_id": 4
}, {
  "id": 100,
  "createDate": "10/23/2020",
  "title": "Marchello",
  "note": "lmarchello2r@slate.com",
  "amount": 806549,
  "wallet_id": 3
}]
""";
