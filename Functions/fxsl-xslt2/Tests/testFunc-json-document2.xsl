<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs" 
 >
 <xsl:import href="../f/func-json-document.xsl"/>
 
 <xsl:variable name="vStr">
 {"ResultSet": 
   {"LastUpdateDate":"1178683597",
    "Result":[{"type":"construction",
               "Title":"Construction work, on I-5 NB at \"SENECA ST\"",
               "Description":"I 5 N Construction work, Left Lane Blocked on I 5 northbound from Seneca Street to Pine Street starting 11:00 PM, 05 08 07 for several days from 11:00pm to 05:00am on Tuesdays, Wednesdays and Thursdays . From milepost 165 to milepost 167",
               "Latitude":"47.614353",
               "Longitude":"-122.329586",
               "Direction":"NB",
               "Severity" :  2,
               "ReportDate":1178604000,
               "UpdateDate":1178608792,
               "EndDate":1178712000},

              {"type":"construction",
               "Title":"Construction work, on I-5 NB at UNIVERSITY ST",
               "Description":"I 5 N Construction work, On ramp Blocked on I 5 northbound at University Street starting 10:00 PM, 05 08 07 until further notice from 10:00pm to 05:00am on Tuesdays, Wednesdays and Thursdays . From milepost 165 to milepost 166",
               "Latitude":"47.615975",
               "Longitude":"-122.328988",
               "Direction":"NB",
               "Severity" : 2,
               "ReportDate":1178600400,
               "UpdateDate":1178608793,
               "EndDate":1178712000},

              {"type":"incident",
               "Title":"Lane closed, on WA-99 at 4TH AVE",
               "Description":"SR 99 Road construction, right lane closed on SR 99 in both directions from 4TH AVE W to 7TH AVE SE starting 8:00 PM, 05 07 07 for a week from 08:00pm to 06:00am on Mondays, Tuesdays, Wednesdays and Thursdays . From milepost 50 to milepost 51",
              "Latitude":"47.634877",
              "Longitude":"-122.344338",
              "Direction":"N\/A",
              "Severity":2,
              "ReportDate":1178506800,
              "UpdateDate":1178608788,
              "EndDate":1178715600}
            ]
   }
}
 </xsl:variable>
 
 <xsl:variable name="vStr2">
 {"ResultSet":{
  "totalResultsAvailable":"229307",
  "totalResultsReturned":"2",
  "firstResultPosition":"1",
  "Result":[
    {
      "Title":"madonna 116",
      "Summary":"Picture 116 of 184\r\n\f\t\b",
      "Url":"http:\/\/www.celebritypicturesarchive.com\/pictures\/m\/madonna\/madonna-116.jpg",
      "ClickUrl":"http:\/\/www.celebritypicturesarchive.com\/pictures\/m\/madonna\/madonna-116.jpg",
      "RefererUrl":"http:\/\/www.celebritypicturesarchive.com\/pgs\/m\/Madonna\/Madonna%20picture_116.htm",
      "FileSize":"36990",
      "FileFormat":"jpeg",
      "Height":"530",
      "Width":"425",
      "Thumbnail":{
        "Url":"http:\/\/scd.mm-b1.yimg.com\/image\/481989943",
        "Height":"125",
        "Width":"100"
       }
    },
    {
      "Title":"madonna 118 \u1089\u1080\u1085",
      "Summary":"Picture 118 of 184 ",
      "Url":"http:\/\/www.celebritypicturesarchive.com\/pictures\/m\/madonna\/madonna-118.jpg",
      "ClickUrl":"http:\/\/www.celebritypicturesarchive.com\/pictures\/m\/madonna\/madonna-118.jpg",
      "RefererUrl":"http:\/\/www.celebritypicturesarchive.com\/pgs\/m\/Madonna\/Madonna%20picture_118.htm",
      "FileSize":"40209",
      "FileFormat":"jpeg",
      "Height":"700",
      "Width":"473",
      "Thumbnail":{
        "Url":"http:\/\/scd.mm-b1.yimg.com\/image\/500892420",
        "Height":"130",
        "Width":"87"
      }
    }
  ]
}
}
 </xsl:variable>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:template match="/">
    Result from string $vStr:
    ==================<xsl:text>&#xA;</xsl:text>
    <xsl:sequence select=
      "f:json-document($vStr)"/>

    Result from string $vStr2:
    ==================<xsl:text>&#xA;</xsl:text>
    <xsl:sequence select=
      "f:json-document($vStr2)"/>


<xsl:variable name="vURL" as="xs:string">../data/trafficData.json</xsl:variable>
    Result from Service:
    ====================<xsl:text>&#xA;</xsl:text>
    <xsl:sequence select=
      "f:json-file-document($vURL)"/>
<!---->
 </xsl:template>
</xsl:stylesheet>