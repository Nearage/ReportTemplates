# Report Templates

Este proyecto está diseñado para facilitar la creación de informes personalizados en Microsoft Dynamics 365 Business Central. Utiliza varios componentes de código y plantillas de informes para generar documentos específicos según las necesidades del usuario.

## Archivos Principales

- `Mathx.codeunit.al`
    - **Propósito**: Implementa una versión mejorada del operador módulo para manejar correctamente los valores negativos.
    - **Funcionalidad**: Proporciona un procedimiento para calcular el módulo que implementa una _corrección para valores negativos_<sup> (1)</sup>_._
- `GlobalLabels.codeunit.al`
    - **Propósito**: Facilita la gestión de etiquetas globales utilizadas en los informes.
    - **Funcionalidad**: Ofrece un procedimiento que devuelve el valor de texto correspondiente a una etiqueta dada.
- `ReportTemplates.codeunit.al`
    - **Propósito**: Contiene lógica y procedimientos para gestionar la estructura y diseño de los informes.
    - **Funcionalidad**:
        - Gestiona la altura del cuerpo del informe y el cálculo de líneas en blanco.
        - Permite la inclusión de DataItems en el proceso de generación de líneas en blanco.
        - Realiza reservas de líneas para secciones dinámicas.
- `Demo*.report.al`
    - **Propósito**: Son ejemplos de implementación de informes utilizando las funcionalidades proporcionadas por el proyecto.
    - **Funcionalidad**: Cada uno de estos archivos define un informe específico, mostrando cómo se pueden utilizar los procedimientos y componentes del proyecto para crear informes personalizados.

## Uso

Para utilizar este proyecto, se deben seguir los siguientes pasos:

- **Configuración**: Asegurar que todos los archivos estén disponibles en el proyecto y configurados correctamente en Microsoft Dynamics 365 Business Central.
- **Personalización**: Personalizar los procedimientos y componentes según las necesidades específicas del informe a generar.
- **Generación de Informes**: Utilizar los ejemplos de informes (`Demo1.report.al`, `Demo2.report.al`, `Demo3.report.al`) como base para desarrollar nuevos informes o modificar los existentes.

## Consideraciones Adicionales

- **Mantenimiento**: Este proyecto debe ser revisado periódicamente para asegurar compatibilidad con nuevas versiones de Microsoft Dynamics 365 Business Central y para incorporar mejoras basadas en feedback de usuarios.
- **Extensibilidad**: Se recomienda extender este proyecto con más componentes y procedimientos para cubrir una gama más amplia de necesidades de informes.

**(1)**: _En AL, la función módulo se cauclula_ `A mod B = A - B * (A \ B)`_, donde `\` representa una división entera en la que se descarta la parte decimal. Sin embargo, esa operación no es del todo correcta, ya que no procesa corréctamente los valores negativos de A. Para corregir este comportamiento, este procedimiento implementa la fórmula_ `A mod B = A - B * ⌊A / B⌋` _en su lugar._
