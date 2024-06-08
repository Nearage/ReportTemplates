# GlobalLabels.codeunit.al

La _codeunit_ [Global Labels](../src/codeunit/GlobalLabels.codeunit.al) contiene los procedimientos necesarios para manejar las etiquetas globales definidas en el proyecto.

## GlobalLabel.enum.al

En el _enum_ [Global Label](../src/enum/GlobalLabel.enum.al) podemos definir las etiquetas globales de nuestro proyecto. De este modo, no será necesario repetir definiciones para valores similares, aumentando la eficiencia y reduciendo la redundancia del código.

## Procedimientos

`Get(Label: Enum "Global Label"): Text`

Este procedimiento obtiene el valor de la etiqueta indicada y lo devuelve formateado como texto. Si el texto contiene marcadores, sus valores se pueden reemplazar con las técnicas estándar.

**Parámetros**:
- `Label: Enum "Global Label"`: La etiqueta de la que se desea obtener el valor.

**Devuelve**: El valor de la etiqueta formateado como texto.

**Ejemplos**:

```al
procedure Hello(Name: Text)
var
    GlobalLabels: Codeunit "Global Labels";
begin
    Message(GlobalLabels.Get("Global Label"::Hello), Name);
end;
```
