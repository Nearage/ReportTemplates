# Documentación general de la _Codeunit_ "Report Templates"

Este documento proporciona una visión general de la _Codeunit_ `"Report Templates"`, componente integral de la biblioteca de Informes concebida para la integración avanzada en el diseño de informes. Dicha _Codeunit_ facilita la elaboración de informes detallados y personalizados mediante la ajuste eficiente de la presentación de datos.

## Estructura

La _Codeunit_ `"Report Templates"` encapsula la lógica destinada a la gestión de la generación de informes. Su enfoque principal radica en el cálculo y manejo de espacios en blanco dentro de los informes, con el objetivo de optimizar su presentación visual.

### Variables Globales

- `BodyHeight`: Variable de tipo _Decimal_ que almacena la altura disponible en el cuerpo del informe, tras descontar los márgenes, el encabezado y el pie de página.
- `NumBlankLins`: Variable de tipo _Integer_ que contiene el número de líneas en blanco necesarias para garantizar una distribución óptima de los elementos del informe.
- `TotalNumLins`: Variable de tipo _Integer_ que acumula el total de líneas utilizadas en el informe, incluyendo tanto las líneas de contenido como aquellas reservadas.

### Triggers y Procedimientos

---

```al
OnRun()
```
Este trigger se activa automáticamente al invocar la _Codeunit_. Establece el rango del _dataitem_ correspondiente a las líneas en blanco, basándose en el valor almacenado en `NumBlankLins`.

---

```al
CalcBlanksRange(LineHeight: Decimal; RsrvHeight: Decimal)
```

Procedimiento encargado de calcular el número de líneas en blanco requeridas para mantener la distribución adecuada de los diversos elementos del informe. Emplea una función auxiliar denominada `Modulo`, perteneciente a otra _Codeunit_ (`Mathx`), para efectuar cálculos involucrando números negativos.

---

```al
CalcBodysHeight(DocHeight: Decimal;
                MarginTop: Decimal; 
                MarginBot: Decimal; 
                HeaderHgt: Decimal; 
                FooterHgt: Decimal): Decimal
```

Este procedimiento calcula el espacio disponible en el cuerpo del informe, restando los márgenes, el encabezado y el pie de página, devolviendo dicha altura como resultado.

---

```al
IncludeDataItem(DataItem: Variant)
```

Permite incorporar un _dataitem_ en el proceso de generación de líneas en blanco, incrementando el contador de registros del _dataitem_ al total de líneas utilizadas.

## Uso

Para hacer uso de las funcionalidades brindadas por esta _Codeunit_, los desarrolladores deben invocar los procedimientos correspondientes con los parámetros necesarios. Esto asegura que el diseño del informe y la distribución del contenido se ajusten a los estándares de presentación deseados.

Generalmente, es suficiente con añadir y configurar corréctamente un _dataitem_ asociado a la tabla `Integer` a nuestro informe, al mismo nivel que el _dataitem_ que genere las líneas en el mismo. En el _trigger_ `OnPreDataItem` de este _dataitem_, deben configurarse los parámetros necesarios para que la _Codeunit_ `"Report Templates"` pueda realizar los cálculos necesarios correctamente.

Su estructura básica es:

```al
dataitem(...; Integer)
{
    column(...; Number) { }

    trigger OnPreDataItem()
    var
        ReportTemplates: Codeunit "Report Templates";
    begin
        ReportTemplates.IncludeDataItem(...);
        ReportTemplates.CalcBodysHeight(...);
        ReportTemplates.CalcBlanksRange(...);
        ReportTemplates.Run(...);
    end;
}
```

Para más información, consultar el código y la documentación de la _Codeunit_ `"Report Templates"`, así como el código y el diseño RDL de los ejemplos _Demo1.report.al_, _Demo2.report.al_ y _Demo3.report.al_.

# Documentación general de la _Codeunit_ "Mathx"

La _Codeunit_ `"Mathx"` implementa operaciones matemáticas que no se incluyen o no se comportan de la forma esperada de manera estándar en AL. Su propósito es agrupar estas funciones en un mismo objeto para facilitar su implementación en otros proyectos.

Por ahora, solo contiene un procedimiento que extiende la definición estándar del operador `mod`, para que pueda procesar correctamente valores negativos del dividendo.

Para más información, consultar el código y la documentación de la _Codeunit_ `"Mathx"`.