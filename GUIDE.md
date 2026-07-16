# Guía de Traducción al Español de la Documentación de PHP

Esta guía establece las directrices, el flujo de trabajo y las reglas de estilo obligatorias para la traducción y mantenimiento de la documentación de PHP al español (`doc-es`), tomando como fuente de verdad absoluta la documentación original en inglés (`doc-en`).

---

## 1. Alineación Estructural y Control de Versiones

### Reglas de Existencia
* **Sincronización:** Cada archivo XML o ENT en español debe ser estructuralmente idéntico a su contraparte en inglés.
* **Eliminaciones:** Si un archivo se elimina en `doc-en`, debe eliminarse de inmediato en `doc-es`.

### Control de Versiones mediante `EN-Revision`
Cada archivo en `doc-es` debe comenzar con un bloque de comentarios XML que indique la revisión de origen en inglés y su estado de revisión:

```xml
<!-- EN-Revision: [hash-de-git-de-doc-en] Maintainer: [nombre-de-traductor] Status: ready -->
<!-- Reviewed: yes Maintainer: [nombre-de-traductor] -->
```

* **Fila 2 (`EN-Revision`):** Muestra el hash del último commit de `doc-en` que se ha integrado. Si actualiza una traducción con cambios del inglés, reemplace el hash y asigne su alias como `Maintainer`.
* **Fila 3 (`Reviewed`):** Indica si la traducción ya fue auditada semánticamente y quién es el revisor responsable de la calidad (por ejemplo, `anonymous`).

---

## 2. Reglas de Estilo y Gramática

Para asegurar la uniformidad de la documentación, se deben seguir estrictamente las siguientes pautas:

* **Tono Impersonal y de "Usted":**
  * Debe dirigirse al lector de manera **impersonal (pasiva refleja)** o utilizando la **fórmula de "usted"**.
  * **Evite el tuteo ("tú")** en todo el manual.
  * *Ejemplo incorrecto:* "Si quieres usar esta función, tienes que configurar..."
  * *Ejemplo correcto:* "Si se desea utilizar esta función, se debe configurar..." o "Si desea utilizar esta función, debe configurar..."
* **Traducción de Cautions y Advertencias:**
  * Utilice el modo imperativo formal ("Evite", "Consulte") o la forma impersonal en lugar de infinitivos.
  * *Ejemplo incorrecto:* "Evitar el uso de esta función..."
  * *Ejemplo correcto:* "Evite el uso de esta función..." o "Se debe evitar el uso de esta función..."

---

## 3. Glosario Técnico Obligatorio

Consulte siempre el archivo `diccionario.md` en la raíz del repositorio para dudas de vocabulario. A continuación se listan las equivalencias más importantes:

| Término en Inglés | Traducción Aceptada | Prohibido / Evitar |
| :--- | :--- | :--- |
| `array` | **array** | matriz, arreglo |
| `string` | **string** | cadena |
| `integer` | **integer** | entero |
| `bool` / `boolean` | **bool** | booleano |
| `float` | **float** | flotante |
| `by default` | **por defecto / predeterminado** | por omisión |
| `library` | **biblioteca** | librería (falso amigo) |
| `argument` | **argumento** | parámetro (el argumento es el valor enviado; el parámetro es la variable receptora) |
| `archive` | **archivo** (ej. un `.zip`) | fichero |
| `file` | **fichero** (ej. un `.php`) | archivo |
| `callback` | **retrollamada / devolución de llamada** | callback |
| `deprecated` | **deprecado / obsoleto** | desaprobado |
| `display` | **mostrar** | desplegar |
| `namespace` | **espacio de nombres** | namespace |
| `seed` (aleatoriedad) | **semilla** | - |
| `seeding` (aleatoriedad) | **inicializar con semilla / establecer la semilla** | sembrar, sembrando |
| `seeding` (bases de datos)| **poblar / precargar** | sembrar |

### Correcciones Ortográficas Críticas:
* **asimismo** (no usar *así mismo*).
* **prever** (no usar *preveer*).
* **caracteres** (sin tilde; la sílaba tónica cambia al pluralizar *carácter*).
* **sobrescribir** (no usar *sobre escribir*).

---

## 4. Preservación del Código XML (DocBook)
* **No traducir etiquetas XML** (`<chapter>`, `<simpara>`, `<literal>`, `<constant>`, `<function>`, etc.).
* **Mantener los parámetros técnicos intactos** dentro de las etiquetas `<parameter>`. Si el parámetro en inglés se llama `<parameter>values</parameter>`, no debe traducirse como `<parameter>valores</parameter>`.
* **Mantener intactas las entidades XML** (`&true;`, `&false;`, `&null;`, `&example.outputs;`).

---

## 5. Compilación y Previsualización Local

Para compilar y verificar el resultado de la documentación localmente, se utiliza Docker y el Makefile provisto.

### Requisitos previos
* **Instalar Docker**: Es necesario tener Docker instalado y ejecutándose en el sistema (https://docs.docker.com/get-docker/).
* **Repositorios locales**: Si los repositorios `doc-en` (manual en inglés), `doc-base` y `phd` están clonados en directorios adyacentes a `doc-es`, el `Makefile` los detectará y montará automáticamente para la compilación.

### Compilación XHTML (Recomendada)
Genera una versión XHTML autocontenida que incluye todos los estilos y es ideal para previsualizar los cambios de manera local y offline:

1. **Compilar la documentación**:
   ```bash
   make
   ```
2. **Levantar un servidor de desarrollo local** (opcional, para navegar cómodamente):
   ```bash
   php -S localhost:4000 -t output/php-chunked-xhtml
   ```
3. **Acceder en el navegador** a la dirección: `http://localhost:4000` (o abrir directamente el archivo `output/php-chunked-xhtml/index.html`).

### Compilación PHP (Formato Web)
Permite generar los archivos en formato PHP destinados a integrarse con el servidor espejo oficial de php.net:

```bash
make php
```
*La salida se colocará en `output/php-web`, pero requiere de la infraestructura del sitio web de php.net para poder visualizarse localmente sin errores.*

### Forzar reconstrucción de la imagen Docker
Si se realizan cambios en la configuración de la imagen Docker y se desea forzar su reconstrucción, ejecute:
```bash
make -B build
```
