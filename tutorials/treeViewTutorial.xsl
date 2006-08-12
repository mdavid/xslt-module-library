<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="tree">
    <html>
      <head>
        <title>Tree View Sample</title>
        <script language="javascript">
          function changeVis(id){
            nodesDeep = <xsl:value-of select="count(descendant::*)"/>;
            display = document.getElementById(id).innerText;
            if(display == "+"){
              document.getElementById(id).innerText = "-";
              for(i=id; i&lt;=nodesDeep; i++){
                 alert(id);
                 eval("document.classes. + id + .div.display") = "inline";
              }
            }
            else{
              document.getElementById(id).innerText = "+";
              for(i=id; i&lt;=nodesDeep; i++){
                alert(id);
                eval("document.classes. + id + .div.display") = "none";
              }
            }
          }    
        </script>
        <style type="text/css">
          <xsl:comment>
            <xsl:apply-templates select="//item[child::*]" mode="css"/>
          </xsl:comment>
        </style>
      </head>
      <body>
        <div style="position:absolute top:0px left:0px">
          <div style="position:relative; float:left; clear:both; margin:0px 0px 0px 0px">
            <xsl:apply-templates select="item">
              <xsl:with-param name="pos" select="count(ancestor::*)"/>
            </xsl:apply-templates>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="item">
  <xsl:param name="pos"/>
    <div class="{$pos}">
      <font color="red">
        <xsl:if test="self::node()[child::*]">
          <a href="#" onclick="changeVis('{$pos }');">
            <label id="{$pos}">+</label>
          </a>
        </xsl:if>
          <xsl:value-of select="@name"/>
          <a href="+">
            <font size="-2">+</font>
          </a>
        <xsl:apply-templates>
          <xsl:with-param name="pos" select="count(ancestor::*)"/>
        </xsl:apply-templates>
      </font>
    </div>
  </xsl:template>
  
  <xsl:template match="item" mode="css">
    div.<xsl:value-of select="count(ancestor::*)"/>{
      display:inline; 
      position:relative; 
      float:left; 
      clear:both; 
      margin:0px 0px 0px 10px
    }
  </xsl:template>
  
</xsl:stylesheet>