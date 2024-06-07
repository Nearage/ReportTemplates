# Mathx.codeunit.al

La _codeunit_ `Mathx` contiene procedimientos matemáticos específicos diseñados para manejar cálculos complejos y precisos en el contexto de las aplicaciones de Microsoft Dynamics 365 Business Central desarrolladas con AL (Application Language). Esta codeunit está destinada a proporcionar funciones matemáticas personalizadas que complementan las capacidades integradas de AL.

## Procedimientos

`Modulo(A: Decimal; B: Decimal): Decimal`

Este procedimiento implementa una versión corregida de la operación módulo (`mod`) que es compatible con valores negativos y proporciona resultados precisos sin importar el signo de los operandos.

- **Parámetros**:
    - `A`: El divisor sobre el cual se calculará el módulo.
    - `B`: El dividendo contra el cual se calculará el módulo.
- **Valores Devueltos**: El valor del módulo de dos números decimales `A` y `B` utilizando la fórmula corregida.

### Ejemplo de Uso

```al
var
    Resultado: Decimal;
begin
    Resultado := Modulo(10, 3); // Devuelve 1
end;
```