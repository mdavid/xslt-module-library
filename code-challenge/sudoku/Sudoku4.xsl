<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs">
 
 <xsl:import href="func-apply.xsl"/>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>

 <xsl:template match="/">

  <xsl:variable name="vFixed" select="f:cellsGroup('Fixed', /*/*)"/>
  <xsl:variable name="vEmpty" select="f:cellsGroup('Empty', /*/*)"/>

  <xsl:variable name="vallFillers" as="element()*">
	  <xsl:for-each select=
	   "f:makeFillers(f:cellsGroup('Fixed', /*/*), f:cellsGroup('Empty', /*/*))">
	    <xsl:sort select="@row"/>
	    <xsl:sort select="@col"/>

	    <xsl:sequence select="."/>
	  </xsl:for-each>
  </xsl:variable>

   <xsl:sequence
     select="f:sudoku($vFixed, $vEmpty, $vallFillers)"/>
 </xsl:template>
 
 <xsl:variable name="vAllVals" select="1 to 9" as="xs:integer+"/>
 
 <xsl:function name="f:cellsGroup" as="element()*">
   <xsl:param name="pgrpType" as="xs:string"/>
   <xsl:param name="pRows" as="element()*"/>
     <xsl:sequence select=
      "for $i in 1 to count($pRows),
            $vRow in $pRows[$i],
                $vNum in tokenize($vRow, ',')
                           [if($pgrpType='Fixed')
                               then . ne '0'
                               else . eq '0'
                           ][if($pgrpType='Empty')
                               then 1
                               else true()],
                $k in index-of(tokenize($vRow, ','),$vNum)
               return
                 f:makeCell($i,$k, xs:integer($vNum))
      "/>
 </xsl:function>

 <xsl:function name="f:makeCell" as="element()">
  <xsl:param name="pnRow" as="xs:integer"/>
  <xsl:param name="pnCol" as="xs:integer"/>
  <xsl:param name="pnVal" as="xs:integer"/>
  
  <cell row="{$pnRow}" col="{$pnCol}" val="{$pnVal}"/>
 </xsl:function>
 
 <xsl:function name="f:sudoku" as="item()*">
   <xsl:param name="pFixedCells" as="element()*"/>
   <xsl:param name="pEmptyCells" as="element()*"/>
   <xsl:param name="pallFillers" as="element()*"/>
   
   <xsl:choose>
    <xsl:when test="empty($pEmptyCells)">
       <xsl:sequence select="f:printBoard($pFixedCells)"/>
    </xsl:when>
    <xsl:otherwise>

     <xsl:variable name="vreducedFillers" select=
      "f:reduceFillersByRules($pallFillers)"
      />
      
		 <xsl:if test="f:canContinue($pFixedCells, $pEmptyCells, $vreducedFillers)">
			 <xsl:variable name="vBestCell" select=
			     "f:bestCellToTry($pEmptyCells,$vreducedFillers)"/>
       <xsl:variable name="vcellFillers" as="element()*"
         select="f:cellFillers($vreducedFillers,$vBestCell)"/>

           <xsl:sequence select=
             "f:tryFillers($pFixedCells,$pEmptyCells, $vreducedFillers,
                           $vcellFillers,$vBestCell)"
             />
      </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:function>
 
 <xsl:function name="f:canContinue" as="xs:boolean">
   <xsl:param name="pFixedCells" as="element()*"/>
   <xsl:param name="pEmptyCells" as="element()*"/>
   <xsl:param name="pallFillers" as="element()*"/>
   
   <xsl:variable name="vallSingleFillers" as="element()*" select=
   "f:getSingleFillers($pallFillers, $pEmptyCells)"
   />
   <xsl:sequence select=
      "if(empty(
                for $i in 1 to 9
                  return
                    $i[f:hasDuplicates(
                                   f:row($vallSingleFillers,$i)/@val
                                       )
                      or
                       f:hasDuplicates(
                                   f:column($vallSingleFillers,$i)/@val
                                       )
                      or
                       f:hasDuplicates(
                                   f:staticRegion($vallSingleFillers,$i)/@val
                                       )  
                       ]
                )
           )
           then
	          true() (: empty($pEmptyCells[empty(f:cellFillers($pallFillers,.))]) :)
	         else
	          false()

      "/>
<!-- -->
 </xsl:function>
 
 <xsl:function name="f:getSingleFillers" as="element()*">
   <xsl:param name="pallFillers" as="element()*"/>
   <xsl:param name="pEmptyCells" as="element()*"/>

   <xsl:for-each select="$pEmptyCells">
    <xsl:variable name="vtheFillers"
      select="f:cellFillers($pallFillers,.)"/>
      
      <xsl:sequence select=
        "if(not($vtheFillers[2]))
           then $vtheFillers[1]
           else ()
        "
        />
  </xsl:for-each>
 </xsl:function>
 
 <xsl:function name="f:hasDuplicates" as="xs:boolean">
  <xsl:param name="pSeq" as="item()*"/>

  <xsl:sequence select="count(distinct-values($pSeq)) ne count($pSeq)"/>
  
 </xsl:function>
 
 <xsl:function name="f:cellFillers" as="element()*">
   <xsl:param name="pallFillers" as="element()*"/>
   <xsl:param name="pemptyCell" as="element()"/>
   
   <xsl:sequence select="$pallFillers[@row eq $pemptyCell/@row
                                     and
                                      @col eq $pemptyCell/@col
                                     ]"/>

 </xsl:function>

 <xsl:function name="f:bestCellToTry" as="element()?">
   <xsl:param name="pEmptyCells" as="element()*"/>
   <xsl:param name="pallFillers" as="element()*"/>

   <xsl:for-each-group select="$pEmptyCells"
    group-by="count(f:cellFillers($pallFillers,.))">
    <xsl:sort select="current-grouping-key()" order="ascending"/>

    <xsl:if test="position() = 1">
     <xsl:sequence select="current-group()[1]"/>
    </xsl:if>
   </xsl:for-each-group>
 </xsl:function>

 <xsl:function name="f:makeFillers" as="element()*">
  <xsl:param name="pFixedCells" as="element()*"/>
  <xsl:param name="pEmptyCells" as="element()*"/>

  <xsl:sequence select="$pEmptyCells/f:makeFillersForCell($pFixedCells,.)"/>
 </xsl:function>

 <xsl:function name="f:makeFillersForCell" as="element()*">
  <xsl:param name="pFixedCells" as="element()*"/>
  <xsl:param name="pEmptyCell" as="element()"/>
  
    <xsl:for-each select="$vAllVals">
      <xsl:if test="not(. = f:column($pFixedCells,$pEmptyCell/@col)/@val)
                  and
                    not(. = f:row($pFixedCells,$pEmptyCell/@row)/@val)
                  and
                    not(. = f:region($pFixedCells, $pEmptyCell)/@val)
                   ">
		    <xsl:sequence select="f:makeCell($pEmptyCell/@row,$pEmptyCell/@col,.)"/>
      </xsl:if>
    </xsl:for-each>
 </xsl:function>

 <xsl:function name="f:tryFillers" as="item()*">
  <xsl:param name="pFixedCells" as="element()*"/>
  <xsl:param name="pEmptyCells" as="element()*"/>
  <xsl:param name="pallFillers" as="element()*"/>
  <xsl:param name="pFillers" as="element()*"/>
  <xsl:param name="pBestCell" as="element()"/>
  
  <xsl:if test="exists($pFillers)">
   <xsl:variable name="vtheFiller" select="$pFillers[1]"/>

   <xsl:variable name="vreducedFilllers" as="element()*"
    select="f:reduceAllFillers($pallFillers, $pBestCell,$vtheFiller)"/>
    
   <xsl:variable name="vSolution" select=
   "f:sudoku(($pFixedCells,$vtheFiller),$pEmptyCells[not(. is $pBestCell)],
             $vreducedFilllers
             )
   "/>
   
     <xsl:choose>
       <xsl:when test="exists($vSolution)">
				 <xsl:sequence select="$vSolution"/>
       </xsl:when>
       <xsl:otherwise>
         <xsl:sequence select=
         "f:tryFillers($pFixedCells,$pEmptyCells, $pallFillers,
                       $pFillers[position() gt 1],$pBestCell)"/>
       </xsl:otherwise>
     </xsl:choose>
  </xsl:if>
 </xsl:function>
 
 <xsl:function name="f:reduceFillersByRules" as="element()*">
  <xsl:param name="pFillers" as="element()*"/>

		<xsl:variable name="vSingleFillers" as="element()*">
	    <xsl:for-each select="f:row(), f:column(), f:staticRegion()">
	      <xsl:variable name="vcurgroupFun" select="."/>
		
		    <xsl:for-each select="1 to 9">
		      <xsl:variable name="vthisGroupFillers"
		          select="f:apply($vcurgroupFun,$pFillers, .)"/>
	
		      <xsl:for-each-group select="$vthisGroupFillers"
		           group-by="@val"
		      >
		        <xsl:sort select="count(current-group())"/>
		        
		        <xsl:if test="not(current-group()[2])">
		         <xsl:sequence select="current-group()[1]"/>
           </xsl:if>
		      </xsl:for-each-group>
		    </xsl:for-each>
	    </xsl:for-each>
    </xsl:variable>

    <xsl:sequence select=
     "for $filler in $pFillers
        return
           if(not(exists($vSingleFillers
                          [not(. is $filler)
                          and
                           @row=$filler/@row
                          and
                           @col=$filler/@col
                           ]
                        )
                 )
              )
           then $filler
           else ()
     "/>
 </xsl:function>
 
 <xsl:function name="f:reduceAllFillers" as="element()*">
  <xsl:param name="pallFillers" as="element()*"/>
  <xsl:param name="ppickedCell" as="element()"/>
  <xsl:param name="pthisFiller" as="element()"/>

  <xsl:sequence select=
  "$pallFillers[(@row ne $ppickedCell/@row
                or
                 @col ne $ppickedCell/@col
                  )
                and
                 (
	                if(@row = $ppickedCell/@row
	                   or
	                    @col = $ppickedCell/@col
	                   or
	                     (
	                      ((@row - 1) idiv 3 eq ($ppickedCell/@row -1) idiv 3)
	                     and
	                       ((@col - 1) idiv 3 eq ($ppickedCell/@col -1) idiv 3)
	                      )
	                    )
	                    then
	                      @val ne $pthisFiller/@val
	                    else
	                      true()
                  )
                 ]
   "
   />
 </xsl:function>
 
 <xsl:variable name="vfunRow" as="element()">
   <f:row/>
 </xsl:variable>

 <xsl:template match="f:row" mode="f:FXSL" as="element()*">
   <xsl:param name="arg1" as="element()*"/>
   <xsl:param name="arg2" as="xs:integer"/>

   <xsl:sequence select="f:row($arg1,$arg2)"/>
 </xsl:template>

 <xsl:function name="f:row" as="element()">
   <xsl:sequence select="$vfunRow"/>
 </xsl:function>

 <xsl:variable name="vfunColumn" as="element()">
   <f:column/>
 </xsl:variable>

 <xsl:template match="f:column" mode="f:FXSL" as="element()*">
   <xsl:param name="arg1" as="element()*"/>
   <xsl:param name="arg2" as="xs:integer"/>

   <xsl:sequence select="f:column($arg1,$arg2)"/>
 </xsl:template>

 <xsl:function name="f:column" as="element()">
   <xsl:sequence select="$vfunColumn"/>
 </xsl:function>

 <xsl:variable name="vfunStatRegion" as="element()">
   <f:staticRegion/>
 </xsl:variable>

 <xsl:template match="f:staticRegion" mode="f:FXSL" as="element()*">
   <xsl:param name="arg1" as="element()*"/>
   <xsl:param name="arg2" as="xs:integer"/>

   <xsl:sequence select="f:staticRegion($arg1,$arg2)"/>
 </xsl:template>

 <xsl:function name="f:staticRegion" as="element()">
   <xsl:sequence select="$vfunStatRegion"/>
 </xsl:function>

 <xsl:function name="f:column" as="element()*">
   <xsl:param name="pCells" as="element()*"/>
   <xsl:param name="pColno" as="xs:integer"/>

   <xsl:sequence select="$pCells[@col = $pColno]"/>
 </xsl:function>

 <xsl:function name="f:row" as="element()*">
   <xsl:param name="pCells" as="element()*"/>
   <xsl:param name="pRowno" as="xs:integer"/>

   <xsl:sequence select="$pCells[@row = $pRowno]"/>
 </xsl:function>

 <xsl:function name="f:region" as="element()*">
   <xsl:param name="pCells" as="element()*"/>
   <xsl:param name="paCell" as="element()"/>

   <xsl:variable name="vregRowStart" as="xs:integer"
        select="3*(($paCell/@row -1) idiv 3) +1"/>
   <xsl:variable name="vregColStart" as="xs:integer"
        select="3*(($paCell/@col -1) idiv 3) +1"/>
        
   <xsl:sequence select=
      "$pCells[xs:integer(@row) ge $vregRowStart and xs:integer(@row) lt ($vregRowStart +3)
				    and
				 	    xs:integer(@col) ge $vregColStart and xs:integer(@col) lt ($vregColStart +3)
              ]"/>
 </xsl:function>
 
 <xsl:variable name="vRegdata" as="element()+">
   <reg rstart="1" colstart="1"/>
   <reg rstart="1" colstart="4"/>
   <reg rstart="1" colstart="7"/>
   <reg rstart="4" colstart="1"/>
   <reg rstart="4" colstart="4"/>
   <reg rstart="4" colstart="7"/>
   <reg rstart="7" colstart="1"/>
   <reg rstart="7" colstart="4"/>
   <reg rstart="7" colstart="7"/>
 </xsl:variable>
 
 <xsl:function name="f:staticRegion" as="element()*">
   <xsl:param name="pCells" as="element()*"/>
   <xsl:param name="pRegNo" as="xs:integer"/>
   
   <xsl:variable name="vregRowStart" as="xs:integer?"
        select="xs:integer($vRegdata[$pRegNo]/@rstart)"/>
   <xsl:variable name="vregColStart" as="xs:integer?"
        select="xs:integer($vRegdata[$pRegNo]/@colstart)"/>

   <xsl:sequence select=
    "$pCells[xs:integer(@row) ge $vregRowStart and xs:integer(@row) lt ($vregRowStart + 3)
            and
							xs:integer(@col) ge $vregColStart and xs:integer(@col) lt ($vregColStart + 3)
            ]"
    />

 </xsl:function>

 <xsl:function name="f:printBoard">
  <xsl:param name="pCells" as="element()+"/>
  
  <xsl:for-each-group select="$pCells" group-by="@row">
    <xsl:sort select="current-grouping-key()"/>
    <row>
       <xsl:for-each select="current-group()">
         <xsl:sort select="@col"/>
         <xsl:value-of select=
          "concat(@val, if(position() ne last()) then ', ' else ())"
          />
       </xsl:for-each>
    </row>
  </xsl:for-each-group>
 </xsl:function>
</xsl:stylesheet>