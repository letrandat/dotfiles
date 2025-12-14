---
description: Design Document, START
auto_execution_mode: 0
---

Act as a senior software design expert writing a design document for a new feature or service. Structure the document as follows:

1. **Problem Statement (Why)**

   - Clearly describe the problem we are solving, including:
     - Who is affected (users, teams, systems)?
     - What pain points or gaps exist today?
     - Why is this important now (business/technical impact)?
   - Keep this section concise and understandable by both technical and non‑technical stakeholders.

2. **High‑Level Solution (What)**

   - Describe the proposed solution at a high level:
     - What will the feature/service do?
     - What are the key capabilities or outcomes?
     - What are the main components or services involved?
   - Avoid diving into implementation details here; focus on the “what” and scope.

3. **Architecture & Flow (How)**

   - Provide a high‑level architecture diagram (please use mermaid):
     - List the main components (e.g., API gateway, backend service, database, message queue, external services).
     - Show how they interact (e.g., “User → API → Service → DB”).
   - Describe the main request flow for a typical use case:
     - Step by step, from user action to final result.
     - For each step, briefly explain what happens and which component is involved.
   - Include simplified, language‑agnostic pseudocode or code snippets to illustrate:
     - Key functions or methods (e.g., `handle_request`, `process_data`, `save_to_db`).
     - Important data structures or messages (e.g., request/response DTOs, events).
   - Mention any key technologies or frameworks (e.g., Node.js, PostgreSQL, Kafka, AWS Lambda).

4. **Assumptions & Constraints**

   - List any assumptions (e.g., “User is authenticated”, “External API is available”).
   - Note any constraints (e.g., performance, scalability, security, existing tech stack).

5. **Risks & Open Questions**
   - Highlight potential risks (e.g., performance bottlenecks, external dependencies).
   - List any open questions that need further discussion (e.g., “How to handle X at scale?”, “Which auth mechanism to use?”).

Use clear, concise language. Prioritize clarity over completeness; this is a design doc, not a full spec.
