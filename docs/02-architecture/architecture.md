# Arquitectura

## Overview

AIKER es una aplicación web modular desarrollada en .NET Core,
que separa claramente la interacción del usuario, la lógica de negocio
y el motor de evaluación basado en inteligencia artificial.

La arquitectura prioriza:
- Separación de responsabilidades
- Evolución independiente del motor de IA
- Testabilidad

Se basa en principios de Clean Architecture adaptados a Blazor.

---

## Estructura General
Blazor (UI)
↓
API / Application
↓
Domain
↓
Infrastructure (SQL Server)
↓
AI Core (Tiny Language Model)

---

## Componentes Principales

### 1. Blazor UI (Presentación)

Responsabilidades:
- Mostrar pruebas
- Recibir respuestas
- Mostrar feedback

Características:
- Lógica mínima
- Orquesta llamados a backend

---

### 2. API Layer

Responsabilidades:
- Exponer endpoints
- Validar requests
- Controlar acceso

Ejemplos:

GET  /tests/{id}
POST /tests/{id}/submit
GET  /results/{id}

---

### 3. Application Layer

Responsabilidades:
- Orquestar casos de uso

Patrón:
- CQRS

Estructura:

/Application
/Commands
/Queries
/Handlers

Ejemplo:

SubmitTestCommand
→ Validación
→ Evaluación
→ Persistencia
→ Respuesta

---

### 4. Domain Layer

Responsabilidades:
- Reglas de negocio
- Entidades

Entidades principales:
- Test
- Question
- Answer
- EvaluationResult

Reglas:
- Respuestas deben estar asociadas
- Evaluación siempre genera feedback
- No se permite doble envío

Características:
- Sin dependencias externas

---

### 5. Infrastructure Layer

Responsabilidades:
- Persistencia
- Integraciones externas

Tecnologías:
- SQL Server
- Entity Framework Core

Estructura:

/Infrastructure
/Persistence
/Repositories

---

### 6. AI Core (Tiny Language Model)

Responsabilidades:
- Evaluar respuestas
- Analizar lenguaje natural
- Generar feedback

Características:
- Independiente del dominio
- Puede evolucionar como servicio separado

Entradas:
- Respuesta del estudiante
- Conceptos esperados

Salidas:
- Feedback
- Evaluación conceptual

---

## Arquitectura de Datos

### Base de Datos: SQL Server

Tablas principales:
- Tests
- Questions
- Submissions
- Answers
- EvaluationResults

Principios:
- Modelo normalizado
- Historial de evaluaciones

---

## Flujo de Datos

### Envío de prueba

1. Usuario envía respuestas
2. API recibe request
3. Application ejecuta comando
4. Domain valida reglas
5. AI evalúa respuestas
6. Se persisten resultados
7. Se devuelve feedback

---

## Aspectos Transversales

### Autenticación
- JWT o cookies

### Logging
- Centralizado
- Con correlation ID

### Manejo de errores
- Formato estándar
- No exponer lógica interna

---

## Modelo de Deploy

### Actual
- Monolito modular
- Base de datos única
- IA integrada

### Futuro
- IA como servicio independiente
- Evaluación asíncrona
- Escalamiento horizontal

---

## Decisiones Clave

### Clean Architecture
Permite desacoplar UI y lógica

### Blazor
Integración nativa con .NET

### SQL Server
Consistencia y compatibilidad

### AI desacoplada
Facilita evolución del sistema

---

## Trade-offs

Ventajas:
- Modularidad
- Testabilidad
- Escalabilidad progresiva

Costos:
- Más estructura
- Mayor complejidad inicial

---

## Riesgos

### Evaluación inconsistente
→ Mitigar con especificaciones claras

### Acoplamiento a datos
→ Mantener dominio independiente

### Performance IA
→ Preparar ejecución asíncrona

---

## Principios Guía

1. UI simple, núcleo inteligente
2. Evaluación explícita y testeable
3. Separación estricta de capas
4. Evolución independiente del AI Core

---

## Futuro

- Arquitectura orientada a eventos
- Workers de evaluación
- Modelos AI especializados
- Segmentación por dominios (Assessment, Evaluation)