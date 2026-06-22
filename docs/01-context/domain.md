# Domain

## Dominio Principal

Evaluación automática de conocimiento basado en respuestas abiertas.

---

## Conceptos Clave

### Test
Conjunto de preguntas asignadas a un usuario

---

### Question
Unidad de evaluación
- Define lo que se espera evaluar

---

### Answer
Respuesta del estudiante
- Texto libre
- Base del análisis

---

### Evaluation
Resultado del análisis
- Puntaje (opcional)
- Feedback
- Cobertura conceptual

---

### Guideline (Pauta)
Define:
- Respuesta esperada
- Conceptos clave
- Criterios de evaluación

---

## Entidades Principales

- Test
- Question
- Answer
- EvaluationResult
- Guideline

---

## Reglas del Dominio

- Toda respuesta debe ser evaluable
- Toda evaluación genera feedback
- Evaluación puede ser parcial
- Feedback debe ser interpretativo, no solo numérico

---

## Subdominios

### 1. Evaluación
- Core del sistema
- Procesamiento semántico

---

### 2. Gestión de pruebas
- Creación
- Distribución

---

### 3. Interacción
- Canales (Web, WhatsApp, Email)

---

## Diferenciador del dominio

El sistema evalúa:
- Significado
- Equivalencia semántica
- Argumentación

No solo coincidencias literales 【1-62ca31】

---

## Complejidad principal

- Interpretar lenguaje humano
- Modelar evaluación parcialmente correcta
- Generar feedback útil

---

## Insight clave

AIKER no es un sistema de evaluación tradicional.
Es un sistema de **interpretación del conocimiento humano**.