<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"	xmlns:tei="http://www.tei-c.org/ns/1.0" version="2.0">
  <xsl:output method="html" version="4.1" encoding="UTF-8"/>
  <xsl:strip-space elements="tei:pubPlace"/>
  <!-- Einige einfache Test-Templates für die Anzeige im Browser -->
  <xsl:template match="/">
    <html>
      <body style="margin:25px 10%;">
        <xsl:apply-templates />
        <footer>
          <p>
            <small>
              <xsl:value-of select="concat('Quelle:',//tei:sourceDesc/tei:bibl,' S. ',//tei:pb[1]/@n)"/>
              <xsl:if test="//tei:pb[1]/@n != (//tei:pb/@n[not(../@ed)])[last()]">
                <xsl:value-of select="concat('–',(//tei:pb/@n[not(../@ed)])[last()])"/>
              </xsl:if>
              <xsl:text>.</xsl:text>
            </small>
          </p>
        </footer>
      </body>
    </html>
  </xsl:template>
  <!-- Template für die Anzeige in der Titelleiste des Browsers -->
  <xsl:template match="tei:teiHeader">
    <head>
      <title>
        <xsl:value-of select="concat(//tei:projectDesc,' - ',//tei:titleStmt/tei:title)"/>
      </title>
    </head>
  </xsl:template>
  <!-- Template für die Anzeige der Seitenzahlen nach der Hauptquelle innerhalb Haupttext -->
  <xsl:template match="tei:div//tei:pb[not(@ed)]">
    <small>
      <sup>
        <xsl:value-of select="@n"/>
      </sup>
    </small>
  </xsl:template>
  <!-- Templates für die Formatierung von Versen -->
  <xsl:template match="tei:lg">
    <xsl:apply-templates />
    <br />
  </xsl:template>
  <xsl:template match="tei:l">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="tei:head">
    <h3>
      <xsl:if test="@rendition='#c'">
        <xsl:attribute name="style">
          <xsl:value-of select="'text-align:center'" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </h3>
  </xsl:template>
  <!-- Templates für die Formatierung von Hervorhebungen -->
  <xsl:template match="tei:hi[@rendition='#b']">
    <span style="font-weight:bold">
      <xsl:apply-templates />
    </span>
  </xsl:template>
  <xsl:template match="tei:hi[@rendition='#c']">
    <span style="text-align:center">
      <xsl:apply-templates />
    </span>
  </xsl:template>
  <xsl:template match="tei:hi[@rendition='#i']">
    <span style="font-style:italic">
      <xsl:apply-templates />
    </span>
  </xsl:template>
  <xsl:template match="tei:hi[@rendition='#k']">
    <span style="font-variant:small-caps">
      <xsl:apply-templates />
    </span>
  </xsl:template>
  <xsl:template match="tei:hi[@rendition='#sub']">
    <sub>
      <xsl:apply-templates />
    </sub>
  </xsl:template>
  <xsl:template match="tei:hi[@rendition='#sup']">
    <sup>
      <xsl:apply-templates />
    </sup>
  </xsl:template>
  <!-- Templates für die Formatierung von Choice-Elementen -->
  <xsl:template match="tei:choice">
    <xsl:choose>
      <xsl:when test="tei:sic">
        <xsl:value-of select="tei:corr"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="*[1]"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="tei:lb">
    <br />
  </xsl:template>
  <xsl:template match="tei:div">
    <div>
      <xsl:apply-templates />
    </div>
  </xsl:template>
  <!-- Template zur Normalisierung des Textes -->
  <xsl:template match="text()">
    <xsl:value-of select="translate(., 'ſ', 's')"/>
  </xsl:template>
</xsl:stylesheet>
