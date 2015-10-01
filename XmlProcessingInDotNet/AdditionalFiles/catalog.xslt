<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/albums">
    <html>
      <body>
        <h1>Albums</h1>
        <xsl:for-each select="album">
        <div>
          <xsl:value-of select="name"/>
        </div>
        <ul>
          <li>
            Artist: <xsl:value-of select="artist"/>
          </li>
          <li>
            Year: <xsl:value-of select="year"/>
          </li>
          <li>
            Producer: <xsl:value-of select="producer"/>
          </li>
          <li>
            Price: <xsl:value-of select="price"/>
          </li>
          <li>Songs</li>
          <ul>
            <xsl:for-each select="songs/song">
            <li>
              <xsl:value-of select="title"/> : <xsl:value-of select="duration"/>
            </li>
            </xsl:for-each>
          </ul>
        </ul>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>