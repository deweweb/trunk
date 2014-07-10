%macro send_http;
    filename request 'h:\sas_basics\proc_HTTP\requestim.xml';
    filename respond 'H:\SAS_BASICS\PROC_HTTP\responseim.xml';

    %let UrlAdr = 'http://wsf.cdyne.com/WeatherWs/Weather.asmx';

    %let SoapRequest=
'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:weat="http://ws.cdyne.com/WeatherWS/">'
  '  <soapenv:Header/>'
  '  <soapenv:Body>'
    '    <weat:GetWeatherInformation/>'
  '  </soapenv:Body>'
'</soapenv:Envelope>';

    data _null_;
        file request;
        put &SoapRequest;
    run; 

    proc http
        in=request
        out=respond
        url=&UrlAdr
        method="post"
        ct="text/xml;charset=utf-8"
        verbose;
    run;

%mend;
%send_http;
