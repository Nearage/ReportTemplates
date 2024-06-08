# Report Templates

Este proyecto está diseñado para facilitar la creación de informes personalizados en Microsoft Dynamics 365 Business Central. Utiliza varios componentes de código y plantillas de informes para generar documentos específicos según las necesidades del usuario.

## Archivos Principales

[Mathx.codeunit.al](./doc/Mathx.codeunit.md)
- Implementa una versión mejorada del operador módulo para manejar correctamente los valores negativos.
- Proporciona un procedimiento para calcular el módulo que implementa una _corrección para valores negativos_ [^1]_._

[GlobalLabels.codeunit.al](./doc/GlobalLabels.codeunit.md)
- Facilita la gestión de etiquetas globales utilizadas en los informes.
- Ofrece un procedimiento que devuelve el valor de texto correspondiente a una etiqueta dada.

[ReportTemplates.codeunit.al](./doc/ReportTemplates.codeunit.md)
- Contiene lógica y procedimientos para gestionar la estructura y diseño de los informes.
- Gestiona la altura del cuerpo del informe y el cálculo de líneas en blanco.
- Permite la inclusión de DataItems en el proceso de generación de líneas en blanco.
- Realiza reservas de líneas para secciones dinámicas.

[Demo1.report.al](./src/report/demo/Demo1.report.al), [Demo2.report.al](./src/report/demo/Demo2.report.al), [Demo3.report.al](./src/report/demo/Demo3.report.al), ...
- Son ejemplos de implementación de informes utilizando las funcionalidades proporcionadas por el proyecto.
- Cada uno de estos archivos define un informe específico, mostrando cómo se pueden utilizar los procedimientos y componentes del proyecto para crear informes personalizados.

## Recomendaciones para Implementación

Para implementar este proyecto, se recomienda tener en cuenta estos aspectos:

- **Configuración**: Asegurarse de que todos los archivos requeridos estén disponibles en el proyecto y configurados correctamente en el entorno.
- **Personalización**: Personalizar los procedimientos y componentes según las necesidades específicas del informe a generar.
- **Generación de Informes**: Utilizar los ejemplos de informes como base para desarrollar nuevos informes o modificar los existentes.

## Consideraciones Adicionales

- **Mantenimiento**: Este proyecto será revisado periódicamente para asegurar compatibilidad con nuevas versiones de Microsoft Dynamics 365 Business Central y para incorporar mejoras basadas en feedback de usuarios.
- **Extensibilidad**: Se recomienda extender este proyecto con más componentes y procedimientos para cubrir una gama más amplia de necesidades de informes.

## Enlaces de Interés
- _Videoguía_ [^2]

[^1]: En AL, la función módulo se cauclula `A mod B = A - B * (A \ B)`, donde `\` representa una división entera en la que se descarta la parte decimal. Sin embargo, esa operación no es del todo correcta, ya que no procesa corréctamente los valores negativos de `A`. Para corregir este comportamiento, este procedimiento implementa la fórmula `A mod B = A - B * ⌊A / B⌋` en su lugar.
[^2]: Esta versión no cuenta con una videoguía por el momento. Se añadirá próximamente y estará disponible mediante este mismo enlace.
