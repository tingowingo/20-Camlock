--[[
 
░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░██╗░░░██╗███████╗██████╗░░█████╗░    ░░██╗██████╗░
░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██║░░░██║██╔════╝╚════██╗██╔══██╗    ░██╔╝╚════██╗
░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░██║╚██╗░██╔╝█████╗░░░░███╔═╝██║░░██║    ██╔╝░░█████╔╝
░░████╔═████║░██╔══╝░░██║░░░░░██║░░██║░╚████╔╝░██╔══╝░░██╔══╝░░██║░░██║    ╚██╗░░╚═══██╗
░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝░░╚██╔╝░░███████╗███████╗╚█████╔╝    ░╚██╗██████╔╝
░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░░░╚═╝░░░╚══════╝╚══════╝░╚════╝░    ░░╚═╝╚═════╝░

--]]

do local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function()return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...)local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v20)if (v1(v20,2)==79) then v19=v0(v3(v20,1,1));return "";else local v74=v2(v0(v20,16));if v19 then local v79=0;local v80;while true do if (v79==1) then return v80;end if (v79==0) then v80=v5(v74,v19);v19=nil;v79=1;end end else return v74;end end end);local function v21(v22,v23,v24)if v24 then local v75=0;local v76;while true do if (v75==0) then v76=(v22/(((4 + 1) -(1962 -(1509 + 450)))^(v23-(433 -(322 + 110)))))%((2 -0)^(((v24-(1 + 0)) -(v23-(2 -1))) + (2 -1))) ;return v76-(v76%1) ;end end else local v77=1725 -(175 + (3821 -2271)) ;local v78;while true do if (v77==(0 -0)) then v78=(515 -(347 + 166))^(v23-(1160 -(566 + (1841 -1248)))) ;return (((v22%(v78 + v78))>=v78) and ((48 -(46 + 1)) + 0)) or (1890 -(502 + (5372 -3984))) ;end end end end local function v25()local v38=71 -(40 + 31) ;local v39;while true do if (v38==(0 -0)) then v39=v1(v16,v18,v18);v18=v18 + 1 + 0 ;v38=1 + 0 ;end if (v38==(1 + 0)) then return v39;end end end local function v26()local v40=0 -0 ;local v41;local v42;while true do if (v40==(1970 -(1507 + 463))) then v41,v42=v1(v16,v18,v18 + 2 + 0 );v18=v18 + ((1940 -(161 + 1173)) -(321 + 283)) ;v40=1;end if (v40==1) then return (v42 * (205 + 51)) + v41 ;end end end local function v27()local v43=0 + 0 ;local v44;local v45;local v46;local v47;while true do if (v43==(1754 -(1295 + 459))) then v44,v45,v46,v47=v1(v16,v18,v18 + (707 -(112 + 592)) );v18=v18 + (1886 -(1245 + 637)) ;v43=1 + 0 ;end if (v43==(1953 -(1360 + 592))) then return (v47 * (65145056 -48367840)) + (v46 * (66593 -(592 + (835 -370)))) + (v45 * 256) + v44 ;end end end local function v28()local v48=v27();local v49=v27();local v50=1 + 0 ;local v51=(v21(v49,1530 -(75 + 1454) ,41 -21 ) * ((344 -(304 + 38))^(70 -38))) + v48 ;local v52=v21(v49,159 -(25 + 113) ,31);local v53=((v21(v49,32)==(4 -3)) and  -(244 -(56 + 187))) or (1 + 0) ;if (v52==(0 -0)) then if (v51==(0 + 0)) then return v53 * ((0 -0) + 0 + 0) ;else local v81=628 -(228 + 400) ;while true do if (v81==((746 -(72 + 674)) -0)) then v52=3 -2 ;v50=0;break;end end end elseif (v52==(4344 -2297)) then return ((v51==0) and (v53 * (((5 -1) -3)/((867 -(312 + 555)) -0)))) or (v53 * NaN) ;end return v8(v53,v52-1023 ) * (v50 + (v51/((7 -5)^(18 + 34)))) ;end local function v29(v30)local v54=0 -0 ;local v55;local v56;while true do if (v54==(0 -0)) then v55=nil;if  not v30 then v30=v27();if (v30==(0 -0)) then return "";end end v54=1 -0 ;end if (v54==(998 -(703 + 292))) then return v6(v56);end if (v54==(3 -2)) then v55=v3(v16,v18,(v18 + v30) -(1 + 0) );v18=v18 + v30 ;v54=926 -(35 + 889) ;end if (v54==(1489 -(253 + 1234))) then v56={};for v82=(2 -1) + (778 -(740 + 38)) , #v55 do v56[v82]=v2(v1(v3(v55,v82,v82)));end v54=3;end end end local v31=v27;local function v32(...)return {...},v12("#",...);end local function v33()local v57=0 + 0 ;local v58;local v59;local v60;local v61;local v62;local v63;local v64;while true do if (v57~=(1253 -(768 + 483))) then else v62=nil;v63=nil;v57=3;end if (v57==(1 + 0)) then v60=nil;v61=nil;v57=2;end if (v57~=(0 + 0)) then else v58=0;v59=nil;v57=1;end if (v57==3) then v64=nil;while true do local v84=0 -0 ;while true do if (v84==0) then if (2~=v58) then else local v104=0;local v105;while true do if (v104~=(0 -0)) then else v105=0 -0 ;while true do if (v105==(0 + 0)) then for v117=1,v63 do local v118=0;local v119;local v120;local v121;local v122;while true do if (v118==2) then while true do if ((1216 -(1184 + 32))~=v119) then else local v145=0 + 0 ;local v146;while true do if ((0 -0)==v145) then v146=0;while true do if ((2 -1)~=v146) then else v119=3 -2 ;break;end if (v146~=0) then else local v164=0 -0 ;while true do if (v164==1) then v146=1;break;end if ((343 -(101 + 242))==v164) then v120=668 -(96 + 572) ;v121=nil;v164=1;end end end end break;end end end if (v119==1) then v122=nil;while true do if (v120~=(0 -0)) then else local v159=1054 -(69 + 985) ;local v160;local v161;while true do if ((1004 -(290 + 714))==v159) then v160=0;v161=nil;v159=1 -0 ;end if (v159~=(3 -2)) then else while true do if (v160==(1178 -(310 + 868))) then v161=0 + 0 ;while true do if (1==v161) then v120=1 + 0 ;break;end if (v161==(676 -(645 + 31))) then local v177=0;while true do if (v177~=(0 + 0)) then else v121=v25();v122=nil;v177=1;end if (v177==1) then v161=16 -(10 + 5) ;break;end end end end break;end end break;end end end if (v120~=1) then else if (v121==(1 + 0)) then v122=v25()~=0 ;elseif (v121==(1 + 1)) then v122=v28();elseif (v121~=3) then else v122=v29();end v64[v117]=v122;break;end end break;end end break;end if (0~=v118) then else v119=0;v120=nil;v118=1 + 0 ;end if (v118==(2 -1)) then local v127=557 -(236 + 321) ;while true do if (v127==1) then v118=1700 -(1186 + 512) ;break;end if (v127~=(1660 -(1386 + 274))) then else v121=nil;v122=nil;v127=1;end end end end end v62[3]=v25();v105=1;end if (v105==(2 -1)) then for v123=1403 -(837 + 565) ,v27() do local v124=0;local v125;local v126;while true do if (v124==1) then while true do if (v125==0) then v126=v25();if (v21(v126,1,1)~=(1402 -(75 + 1327))) then else local v147=0 + 0 ;local v148;local v149;local v150;local v151;while true do if (v147==(0 + 0)) then v148=1753 -(116 + 1637) ;v149=nil;v147=1 + 0 ;end if ((329 -(251 + 76))~=v147) then else while true do if (v148~=0) then else local v168=0;while true do if (v168==1) then v148=1942 -(1240 + 701) ;break;end if (v168~=(1644 -(365 + 1279))) then else v149=v21(v126,3 -1 ,3 + 0 );v150=v21(v126,2 + 2 ,18 -12 );v168=1;end end end if (v148==(11 -8)) then if (v21(v150,3,1166 -(1098 + 65) )==1) then v151[3 + 1 ]=v64[v151[5 -1 ]];end v59[v123]=v151;break;end if (v148==2) then local v170=0;while true do if (v170~=(1 + 0)) then else v148=3;break;end if (v170==0) then if (v21(v150,242 -(238 + 3) ,286 -(215 + 70) )==(1 -0)) then v151[2]=v64[v151[1910 -(205 + 1703) ]];end if (v21(v150,1859 -(1483 + 374) ,2)==1) then v151[11 -8 ]=v64[v151[3]];end v170=1;end end end if (v148~=(1 + 0)) then else v151={v26(),v26(),nil,nil};if (v149==(0 -0)) then local v174=0;local v175;local v176;while true do if (v174==0) then local v185=0 -0 ;while true do if (v185~=(30 -(18 + 11))) then else v174=1 + 0 ;break;end if (v185==0) then v175=0;v176=nil;v185=1;end end end if (v174~=(2 -1)) then else while true do if (v175~=(1597 -(429 + 1168))) then else v176=0;while true do if (v176~=0) then else v151[2 + 1 ]=v26();v151[4]=v26();break;end end break;end end break;end end elseif (v149==(1 + 0)) then v151[3]=v27();elseif (v149==(1005 -(764 + 239))) then v151[872 -(39 + 830) ]=v27() -((401 -(369 + 30))^(809 -(197 + 596))) ;elseif (v149==(1880 -(615 + 1262))) then local v187=0 + 0 ;local v188;local v189;while true do if (v187~=1) then else while true do if (v188==(0 -0)) then v189=0 + 0 ;while true do if (v189==(1228 -(214 + 1014))) then v151[670 -(499 + 168) ]=v27() -((7 -5)^(55 -(10 + 29))) ;v151[4]=v26();break;end end break;end end break;end if (v187==(1651 -(236 + 1415))) then local v192=0;while true do if (v192==1) then v187=1 -0 ;break;end if (v192==0) then v188=0;v189=nil;v192=592 -(327 + 264) ;end end end end end v148=2;end end break;end if (v147~=1) then else v150=nil;v151=nil;v147=836 -(529 + 305) ;end end end break;end end break;end if (v124==(0 + 0)) then v125=0;v126=nil;v124=1;end end end v58=3 -0 ;break;end end break;end end end if (v58==0) then local v106=979 -(957 + 22) ;while true do if (v106==0) then v59={};v60={};v106=1 + 0 ;end if (v106~=1) then else v61={};v58=3 -2 ;break;end end end v84=1;end if (v84~=(2 -1)) then else if (v58~=(3 -2)) then else local v107=0;while true do if (v107~=(2 -1)) then else v64={};v58=2;break;end if (0==v107) then local v109=0;while true do if (v109==(1144 -(970 + 173))) then v107=1;break;end if (v109==0) then v62={v59,v60,nil,v61};v63=v27();v109=1 -0 ;end end end end end if (v58~=(392 -(122 + 267))) then else local v108=0;while true do if (v108==0) then for v110=127 -(12 + 114) ,v27() do v60[v110-(1 + 0) ]=v33();end for v112=1,v27() do v61[v112]=v27();end v108=1;end if (v108==1) then return v62;end end end break;end end end break;end end end local function v34(v35,v36,v37)local v65=v35[1];local v66=v35[2];local v67=v35[3];return function(...)local v68=0;local v69;local v70;local v71;local v72;local v73;while true do if (v68==2) then v73=nil;v73=function()local v85=v65;local v86=v66;local v87=v67;local v88=v32;local v89={};local v90={};local v91={};for v95=1546 -(110 + 1436) ,v72 do if ((4251>=(5433 -(108 + 1348))) and (v95>=v87)) then v89[v95-v87 ]=v71[v95 + 1 + 0 ];else v91[v95]=v71[v95 + (1336 -(1099 + 236)) ];end end local v92=(v72-v87) + ((4128 -2912) -(243 + 972)) ;local v93;local v94;while true do local v96=1259 -(763 + 496) ;local v97;local v98;while true do if ((v96==(881 -(617 + 264))) or (222>(2897 -(1147 + 338)))) then v97=0 -0 ;v98=nil;v96=2 -1 ;end if (((3781 + 698)<(1321 + 3431)) and ((30 -(12 + 17))==v96)) then while true do if ((((3129 -2048) -(233 + 197 + 290))<=419) and (v97==((2463 -(1063 + 131)) -(846 + 423)))) then v98=1100 -(646 + 454) ;while true do if ((v98==1) or ((2599 -(75 + 496))==(2958 + 1895))) then if ((v94<=(432 -(233 + 197))) or ((1760 + (5379 -2782))<(1708 + 2315))) then if (((1053 + 108)<=3828) and (v94<=(0 -0))) then do return;end elseif (((345 + 589)<=(91 + (2790 -1000))) and (v94>((549 -358) -(87 + 103)))) then v91[v93[2 + 0 ]]=v37[v93[2 + (2 -1) ]];else local v130=1246 -(750 + 496) ;local v131;local v132;while true do if (((1116 + 1337)<=(12896 -8566)) and (v130==((3 + 1) -3))) then v91[v131 + 1 + 0 ]=v132;v91[v131]=v132[v93[1335 -(189 + 1142) ]];break;end if ((v130==(1039 -(710 + 329))) or ((1613 -(65 + 34))>=(4945 -(1069 + 605)))) then v131=v93[2];v132=v91[v93[780 -(331 + 304 + 142) ]];v130=1 + (1496 -(870 + 626)) ;end end end elseif ((406<(7906 -5036)) and (v94<=(1510 -(718 + 788)))) then if (((5244 -(212 + 562))>(2990 + 641)) and (v94==(1435 -(280 + (2839 -(1379 + 308)))))) then v91[v93[5 -3 ]]=v93[3];else local v135=1481 -(1341 + 140) ;local v136;while true do if (((10186 -(2181 + 4488))>=(1 + 24)) and (v135==(0 -(0 + 0)))) then v136=v93[2 + 0 ];v91[v136]=v91[v136](v13(v91,v136 + (1721 -(1030 + 690)) ,v70));break;end end end elseif (((3662 -(1310 + 515))==(2634 -(764 + 33))) and (v94==(1444 -(1344 + 95)))) then v91[v93[1 + 1 ]]();else local v137=511 -(357 + 154) ;local v138;local v139;local v140;local v141;local v142;while true do if ((((5113 -2989) -(5 + 688 + 470))>=395) and (v137==(2 -1))) then v140=nil;v141=nil;v137=(4 -1) -1 ;end if (((14855 -9886)>(9795 -5983)) and (v137==(0 -(0 + 0)))) then v138=0 -0 ;v139=nil;v137=2 -1 ;end if ((((1085 -(198 + 39)) + 1255)<(3769 -(557 + 347))) and (v137==2)) then v142=nil;while true do if ((v138==(6 -4)) or (((5708 -(548 + 657)) -(1569 + 63))<(7286 -5414))) then for v165=v139,v70 do local v166=0 + (1802 -(1617 + 185)) ;local v167;while true do if ((v166==(0 -0)) or ((598 -(137 + 37))>=2352)) then v167=1136 -(978 + 158) ;while true do if (((253 + 1864)==2117) and ((0 + 0)==v167)) then v142=v142 + 1 + 0 ;v91[v165]=v140[v142];break;end end break;end end end break;end if (((11 + 36 + 2091)>(3545 -(994 + 802))) and ((0 + 0)==v138)) then local v163=1863 -(997 + 866) ;while true do if (((111 -29)==82) and ((0 + 0)==v163)) then v139=v93[2];v140,v141=v88(v91[v139](v13(v91,v139 + 1 + 0 ,v93[3])));v163=2 -1 ;end if ((v163==(4 -3)) or ((955 -461)>3551)) then v138=1;break;end end end if ((v138==(1822 -(613 + 1208))) or (2220<(1826 -(936 + 663)))) then v70=(v141 + v139) -1 ;v142=0 -0 ;v138=2 + 0 ;end end break;end end end v69=v69 + 1 + 0 ;break;end if ((v98==(0 -0)) or (((1090 -(122 + 514)) + 1205)==(278 + 1318))) then local v115=0 + 0 ;local v116;while true do if (((2522 -(398 + 90 + 163))<4883) and (v115==(0 -0))) then v116=0 -0 ;while true do if ((v116==0) or ((3762 -(121 + 441))<=(1049 -623))) then v93=v85[v69];v94=v93[(1684 -(714 + 968)) -1 ];v116=1;end if ((4045>(3995 -(224 + 1177))) and ((3 -2)==v116)) then v98=1 + 0 ;break;end end break;end end end end break;end end break;end end end end;v68=3;end if (v68==3) then A,B=v32(v11(v73));if  not A[1] then local v99=v35[4][v69] or "?" ;error("Script error at ["   .. v99   .. "]:"   .. A[2] );else return v13(A,2,B);end break;end if (v68==1) then v71={...};v72=v12("#",...) -1 ;v68=2;end if (0==v68) then v69=1;v70= -1;v68=1;end end end;end return v34(v33(),{},v17)(...);end v15("LOL!043O00030A3O006C6F6164737472696E6703043O0067616D6503073O00482O747047657403413O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F74696E676F77696E676F2F32302D43616D6C6F636B2F6D61696E2F636F6D7000083O0012023O00013O001202000100023O002001000100010003001203000300044O0006000100034O00045O00022O00053O000100016O00017O00083O00023O00023O00023O00023O00023O00023O00023O00033O00",v9(),...);end
