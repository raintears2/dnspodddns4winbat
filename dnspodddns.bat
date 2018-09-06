

set "URL=http://ip.cn"
set "ipchange=0"

for /f "tokens=2 " %%a in ('curl -s "%URL%" ^|iconv -f utf-8 -t gbk') do (
    set "PublicIP=%%a"
)


for /f "tokens=2 delims=[：]" %%a in ('echo %PublicIP%') do (
    set "IP=%%a"
)


echo %URL%
echo %PublicIP%
 
if not exist c:\adslip.txt (
echo adslip.txt not exist
echo %IP% > c:\adslip.txt

set "ipchange=1"


) else (

echo adslip.txt exist

for /f "tokens=1" %%d in (c:\adslip.txt) do (
    
    echo %%d
    
    if /i "%%d" neq "%IP%" (
       echo %%d is not equal old ip
       set "ipchange=1"

    ) 
)

)

echo %ipchange% 

SET "API_TOKEN=11111,000000000000000000000000000"
SET "DOMAIN=XXX.COM"
SET "SUBDOMAIN=WWW"
SET  "DOMAINID=11111"
SET  "RECORDID=22222"

if %ipchange% equ 1 (

echo ip change


curl -X POST https://dnsapi.cn/Record.List -d "login_token=%API_TOKEN%&format=json&lang=en&error_on_empty=yes&domain=%DOMAIN%&sub_domain=%SUBDOMAIN%"

echo null
echo null

curl -X POST https://dnsapi.cn/Record.Ddns -d "login_token=%API_TOKEN%&format=json&domain_id=%DOMAINID%&record_id=%RECORDID%&record_line_id=10%3D0&sub_domain=%SUBDOMAIN%"


)



rem spause


