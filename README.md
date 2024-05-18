# Plantillas para diseño de informes dinámicos.
Este repositorio contiene el código y el diseño de varios informes de ejemplo en lenguaje AL y RDL. Estos informes integran funcionalidades adicionales, que amplían las capacidades de Report Builder y permiten controlar con precisión la distribución de los distintos elementos presentes en ellos.

Haciendo uso de estas funcionalidades es posible, por ejemplo, añadir una sección al informe que se mantenga siempre al final, junto al pie de página o al final de la misma.

>El informe _Demo 1_ implementa esta funcionalidad. Para más información, ver:
>- **MD**: DEMO1.md
>- **AL**: src/report/Demo1.report.al<br>
>- **RDL**: src/report/layout/Demo1.rdl

Otra posibilidad que ofrecen estos informes, es la de definir un par de filas de la tabla principal, a modo de cabecera y pie de página, lo cual, combinado con el ejemplo anterior, permite generar informes en los que es posible controlar cuándo deben mostrarse dichas secciones. Así, por ejemplo, puede añadirse una sección adicional al informe, que sólo se mostrará al final del mismo y no incluirá cabecera ni pie de página.

>Esta funcionalidad aún no ha sido implementada en ningún ejemplo.