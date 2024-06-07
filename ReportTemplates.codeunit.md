# ReportTemplates.codeunit.al

La _codeunit_ `Report Templates` contiene lógica y procedimientos para gestionar la estructura y diseño de los  informes.

## Variables Globales

- **`BodyHeight` (Decimal)**: Representa la altura disponible en el cuerpo del informe. Se utiliza para calcular el espacio restante después de considerar otros elementos como márgenes, cabeceras y pies de página.
  
- **`LineHeight` (Decimal)**: Define la altura de cada línea en el informe. Es fundamental para calcular el número de líneas que pueden caber en el espacio disponible y para determinar el número de líneas en blanco necesarias.
  
- **`NumBlankLins` (Integer)**: Indica el número de líneas en blanco a añadir. Este valor se calcula dinámicamente basándose en el diseño del informe y se utiliza para mejorar la legibilidad y el equilibrio visual.
  
- **`TotalNumLins` (Integer)**: Contabiliza el número total de líneas reservadas en el informe. Este contador es crucial para entender cuánto espacio se ha reservado para contenido y cuánto para espacios en blanco.

## Procedimientos y Funciones

#### `Init(DefaultLineHeight: Decimal)`

Inicializa las variables y establece la altura por defecto para las líneas del informe. Es esencial para configurar el estado inicial del objeto antes de comenzar a calcular el diseño del informe.

- **Parámetros**:
  - **`DefaultLineHeight` (Decimal)**: Altura por defecto de las líneas del informe. Es el punto de partida para calcular el diseño del informe.

#### `CalcBlanksRange(RsrvHeight: Decimal)`

Calcula el número de líneas en blanco necesarias para mantener la distribución de los distintos elementos del informe, teniendo en cuenta la altura reservada.

- **Parámetros**:
  - **`RsrvHeight` (Decimal)**: Altura reservada para secciones adicionales. Representa el espacio adicional que se desea dejar libre en el informe para futuras modificaciones o para contenido dinámico.

#### `CalcBodysHeight(DocHeight, MarginTop, MarginBot, HeaderHgt, FooterHgt)`

Calcula el espacio disponible en el cuerpo del informe descontando márgenes, cabecera y pie de página. Es fundamental para determinar el espacio efectivo para el contenido del informe.

- **Parámetros**:
  - **`DocHeight` (Decimal)**: Altura total del documento.
  - **`MarginTop` (Decimal)**: Margen superior.
  - **`MarginBot` (Decimal)**: Margen inferior.
  - **`HeaderHgt` (Decimal)**: Altura de la cabecera.
  - **`FooterHgt` (Decimal)**: Altura del pie de página.

#### `IncludeDataItem(DataItem: Variant)`

Incluye el DataItem proporcionado en el proceso de generación de líneas en blanco, preparándolo para su inclusión en el informe.

- **Parámetros**:
  - **`DataItem` (Variant)**: DataItem a incluir en el proceso. Puede ser cualquier tipo de dato que se desee representar en el informe.

#### `ReservBodyLines(RsrvLins: Integer)`

Reserva líneas en el cuerpo del informe, reduciendo la altura disponible para el contenido. Es útil para preparar espacio para secciones dinámicas que pueden repetirse en cada página.

- **Parámetros**:
  - **`RsrvLins` (Integer)**: Número de líneas a reservar en el cuerpo del informe. Representa el espacio que se desea dejar libre para contenido dinámico o secciones que pueden variar en tamaño.