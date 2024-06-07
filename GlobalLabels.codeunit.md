# GlobalLabels.codeunit.al

La _codeunit_ `Global Labels` contiene los procedimientos necesarios para manejar las etiquetas globales definidas en el proyecto.

## GlobalLabels.enum.al

En este _enum_ podemos definir las variables globales de nuestro proyecto. De este modo, no será necesario repetir definiciones para valores similares, aumentando la eficiencia y reduciendo la redundancia del código.

```al
enum "Global Label"
{
    value(1; Hello) { Caption = 'Hello World!'; }
    ...
}
```

## Procedimientos

#### `procedure Get(Label: Enum "Global Label"): Text`

Este procedimiento obtiene el valor de la etiqueta indicada y lo devuelve formateado como texto. Si el texto contiene marcadores, sus valores se pueden reemplazar con las técnicas estándar.

- **Parámetros**:
    - `Label`: La etiqueta de la que se desea obtener el valor.
- **Valores Devueltos**: El valor de la etiqueta formateado como texto.



### Ejemplo de Uso

```al
var
    GlobalLabels: Codeunit "Global Labels";
begin
    Message(GlobalLabels.Get("Global Label"::Hello))
end;
```