# Conventions

## Objetivo

Este documento define las convenciones obligatorias para el desarrollo en AIKER.
Su propósito es garantizar:

- Consistencia en el código
- Mantenibilidad
- Bajo acoplamiento
- Claridad en la intención

---

## Principios Generales

1. El código debe ser fácil de leer antes que flexible
2. Cada decisión debe ser explícita
3. Evitar lógica implícita o "magia"
4. Preferir composición sobre herencia
5. La complejidad debe estar en el Application Layer, no en UI

---

## Arquitectura

Se sigue una estructura basada en:

/src
/Api
/Application
/Domain
/Infrastructure

Reglas obligatorias:

- Domain no depende de nada
- Application depende de Domain
- Infrastructure depende de Application/Domain
- UI depende solo de Application

---

## CQRS

### Definición

Separar el sistema en:

- Commands → modifican estado
- Queries → leen estado

---

### Naming

#### Commands
Formato:

<Acción>Command

Ejemplos:
- `SubmitTestCommand`
- `CreateUserCommand`

---

#### Queries
Formato:

Get<Condición>Query

Ejemplos:
- `GetTestByIdQuery`
- `GetResultsByUserQuery`

---

#### Handlers
Formato:

<Command|Query>Handler

Ejemplos:
- `SubmitTestCommandHandler`
- `GetTestByIdQueryHandler`

---

### Reglas CQRS

- Un handler → una responsabilidad
- Commands no retornan entidades, solo resultado simple
- Queries no tienen efectos secundarios
- No mezclar lógica de lectura y escritura

---

### Flujo estándar


UI → Command → Handler → Domain → Infrastructure

---

## Application Layer

### Responsabilidades

- Orquestar lógica
- Validar inputs básicos
- Llamar al Domain y servicios externos

### Restricciones

- No contiene lógica de negocio compleja
- No accede directamente a DB
- No contiene lógica de presentación

---

## Domain Layer

### Responsabilidades

- Reglas de negocio
- Invariantes
- Modelos principales

---

### Reglas

- No usar EF Core aquí
- No usar servicios externos
- No depender de frameworks

---

### Diseño

- Entidades con comportamiento
- Evitar modelos anémicos

Ejemplo (incorrecto):

class Answer {
string Text;
}

Ejemplo (correcto):

class Answer {
string Text;
bool IsValid() { ... }

}

---

## Infrastructure Layer

### Responsabilidades

- Persistencia (SQL Server)
- Integraciones externas
- Implementaciones de repositorios

---

### EF Core

Reglas:

- Configuración en `DbContext`
- Uso de Fluent API (no Data Annotations)
- No exponer entidades EF directamente al Application

---

### Repositorios

- Usar solo cuando agregan valor
- Evitar repositorios genéricos innecesarios

---

## Blazor (UI)

### Principios

- UI debe ser delgada
- Sin lógica de negocio
- Solo orquestación

---

### Estructura


/Ui
/Pages
/Components
/Services

---

### Naming

- Páginas: `TestPage.razor`
- Componentes: `QuestionCard.razor`

---

### Reglas

- No llamar directamente a Infrastructure
- Usar servicios de Application
- Manejar estado UI local (no lógica de negocio)

---

### Manejo de estado

- Preferir estado simple
- Evitar lógica compleja en componentes
- Delegar decisiones al Application Layer

---

## API

### Diseño

- REST básico
- Endpoints claros

Ejemplo:

GET  /tests/{id}
POST /tests/{id}/submit

---

### Respuestas

Formato estándar:


{
"success": true,
"data": {},
"errors": []
}

---

### Errores

Formato:


{
"code": "ERROR_CODE",
"message": "Descripción clara"
}

---

## Validaciones

- Validaciones simples → Application
- Reglas complejas → Domain

---

## Logging

### Reglas

- Log obligatorio en errores
- No loggear datos sensibles
- Usar correlation ID

---

## Manejo de errores

- No usar excepciones para lógica de negocio
- Usar resultados controlados (Result pattern)

---

## AI Core

### Integración

- Se trata como servicio externo interno

---

### Reglas

- No mezclar lógica AI con Domain
- AI solo evalúa, no decide reglas de negocio
- Toda evaluación debe ser reproducible

---

## Testing

### Tipos

- Unit tests → Domain
- Integration tests → API/Application

---

### Reglas

- No testear frameworks
- Testear reglas de negocio

---

## Naming General

- Clases → PascalCase
- Métodos → PascalCase
- Variables → camelCase

---

## Organización del Código

- Un archivo por clase
- Evitar archivos grandes (>300 líneas)
- Agrupar por feature cuando sea posible

---

## Pull Requests

Checklist obligatorio:

- [ ] Command/Query definido correctamente
- [ ] No hay lógica en UI
- [ ] Domain encapsula reglas
- [ ] Tests agregados (si aplica)
- [ ] Documentación actualizada

---

## Anti-Patterns Prohibidos

- Fat Controllers
- Lógica de negocio en Blazor
- Repositorios genéricos innecesarios
- Mezclar lectura y escritura
- Acceso directo a DB desde UI

---

## Resumen

Este sistema se basa en tres reglas clave:

1. CQRS separa responsabilidades
2. Domain protege la lógica
3. Blazor solo muestra y orquesta

Si alguna decisión rompe estas reglas, debe justificarse explícitamente.