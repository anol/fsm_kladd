

rem Using Microsoft XSLT Processor Version 3.0
msxsl ebax.xml xfsm2h.xsl -o ebax.h
msxsl ebax.xml xfsm2c.xsl -o ebax.c
msxsl ebax.xml xfsm2g.xsl -o ebax.gv

rem Using dot - Graphviz version 2.38.0
dot -Tpng -oebax.png ebax.gv

