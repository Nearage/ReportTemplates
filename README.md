# Plantilla para diseño de informes dinámicos con secciones adicionales.

Esta rama contiene el código y el diseño de un informe AL/RDL de ejemplo, que integra la funcionalidad necesaria para distribuir la altura del documento, de manera que las secciones adicionales se sitúen al final del mismo, junto al pie de página, si lo hay.

En este informe se ha incluido el _dataitem_ **Blanks** y se ha exportado la el campo _Number_ como una columna del mismo.

># Aviso
>Es posible que, tras aplicar el procedimiento desarrollado, quede un espacio en blanco entre la útlma sección adicional y el pie de página. Esto ocurre cuando la altura de las líneas insertadas, incluídas las líneas en blanco y las líneas reservadas para secciones adicionales, no es suficiente para completar la altura del cuerpo completamente. No es necesario, pero si se desea, es posible rellenar este espacio. Para ello, basta con calcular la diferencia entre la altura del cuerpo y la altura total de las líneas insertadas, en blanco y reservadas. La altura resultante debe añadirse a cualquier sección estática del informe que se repita en las mismas páginas que la tabla principal; normalmente, cabecera o pie de página. 
>
>- La fórmula para calcular el espacio no usado es: `H - (L * l)`, donde `H` es la altura del cuerpo, `L` es el número de líneas que caben en una página, y `l` es la altura de cada línea.
>- La fórmula para calcular `L` es: `H div l`, donde _div_ representa una división de números enteros, descartando la parte decimal.
>- La fórmula combinada es: `H - (H div l) * l`.
>
>Por ejemplo, si la altura del cuerpo es `9,69 in` y la de las líneas `0,25 in`, el número de líneas por página es `9,69 div 0,25 = 38`. Con ese dato, el espacio no usado es `9,69 - 38 * 0,25 = 0,19 in`. Por tanto, debe añadirse `0,19 in` a cualquiera de las secciones estáticas del informe que se repitan junto a la tabla principal.
>
>La fórmula combinada permite obtener el mismo resultado diréctamente, simplificando el proceso: `9,69 - (9,69 div 0,25) * 0,25 = 0,19 in`.
>
>\* _Nótese que, pese a dividir y multiplicar inmediatamente por el mismo valor, la operación no se anula debido a que no se trata de una división común, ya que la parte decimal se descarta con el operador_ `div`.
>
>&nbsp;