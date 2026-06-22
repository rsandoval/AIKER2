# AIKER – Plataforma Inteligente de Evaluación

## Overview

AIKER es una plataforma de evaluación de conocimiento basada en inteligencia artificial, diseñada para analizar respuestas abiertas y generar retroalimentación detallada sobre argumentación y comprensión conceptual.

El sistema permite:
- Rendición de pruebas
- Evaluación automática de respuestas abiertas
- Generación de feedback estructurado

AIKER se enfoca en evaluar el **razonamiento y la argumentación**, no solo palabras clave.

---

## Evolución del Proyecto

El sistema actual ha demostrado valor real en entornos educativos, pero presenta limitaciones:

### Limitaciones actuales
- Problemas de rendimiento con concurrencia (>20 estudiantes)
- Flujo rígido basado en archivos `.docx`
- Canal único de interacción

---

## Objetivos del Nuevo AIKER

### 1. Evolución del motor de IA (TLM)
- Mejorar comprensión semántica
- Evaluación más consistente
- Feedback más explicativo
- Base para múltiples modelos

---

### 2. Arquitectura Escalable
- Eliminar cuellos de botella en descarga de pruebas
- Soportar alta concurrencia
- Separar evaluación del flujo principal
- Preparar procesamiento asíncrono

---

### 3. Nuevos Canales de Interacción

AIKER evoluciona desde un modelo centrado en archivos a un sistema multicanal:

- UI web (Blazor)
- WhatsApp (envío y respuesta)
- Email (respuesta en el cuerpo del mensaje)

---

## Capacidades Principales

### Evaluación de respuestas abiertas
AIKER analiza:
- Argumentación
- Cobertura conceptual
- Calidad de razonamiento  

Permite detectar equivalencias semánticas entre respuesta esperada y respuesta real 【1-62ca31】

---

### Evaluación inmediata
Cada respuesta es:
- Interpretada automáticamente
- Evaluada según pauta
- Retroalimentada en tiempo real 【1-62ca31】

---

### Feedback de aprendizaje
- Identifica errores
- Evalúa parcialidad (no solo correcto/incorrecto)
- Mejora aprendizaje iterativo

---

## Arquitectura General
Client Layer

Blazor UI
WhatsApp
Email

Application Layer (CQRS)

Commands / Queries
Orquestación

Domain Layer

Evaluación
Tests
Reglas

Infrastructure

SQL Server
Mensajería / integraciones

AI Core (TLM)

Evaluación semántica


---

## Flujo Principal

1. Usuario recibe una prueba (web / mensaje / email)
2. Usuario envía respuestas
3. Sistema procesa respuestas
4. AIKER:
   - Evalúa contenido
   - Asigna nivel de cumplimiento
5. Se genera feedback
6. Se entregan resultados

---

## Principios del Sistema

### 1. Evaluar pensamiento, no keywords
AIKER analiza argumentos completos, no coincidencias superficiales 【1-62ca31】

---

### 2. Feedback como herramienta central
El objetivo no es solo calificar, sino mejorar aprendizaje

---

### 3. IA como componente desacoplado
El motor puede evolucionar independientemente

---

### 4. Multicanal nativo
La interacción no depende de un solo canal

---

## Usuarios

### Estudiantes
- Rinden pruebas
- Reciben feedback inmediato

### Docentes
- Definen preguntas y pautas
- Supervisan evaluaciones

### Instituciones
- Gestionan cursos
- Monitorean desempeño

---

## No Objetivos

- Reemplazar LMS completos
- Crear editores complejos de contenido
- UI sofisticada (no es el foco)

---

## Dirección Futura

- Evaluación asíncrona distribuida
- Modelos AI especializados por dominio
- Adaptación dinámica de pruebas
- Integración con sistemas académicos

---

## Resumen

AIKER evoluciona desde una herramienta de evaluación automática a una plataforma:

- Escalable
- Multicanal
- Inteligente
- Centrada en el aprendizaje profundo