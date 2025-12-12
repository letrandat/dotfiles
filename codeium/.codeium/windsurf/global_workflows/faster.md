---
description: Faster (after tester), START
auto_execution_mode: 1
---

Act as a Senior Performance Engineer and rewrite this code to maximize performance and efficiency while preserving its exact behavior and external interface. Focus on:

- Minimizing execution time (CPU cycles, hot paths, tight loops)
- Reducing memory allocations and pressure (avoid unnecessary copies, reuse buffers, prefer stack where safe)
- Eliminating redundant or repeated work (cache expensive results, avoid recalculating)
- Using faster algorithms or data structures where applicable (e.g., hash maps over linear search, bit operations over conditionals)
- Leveraging language-specific performance features (e.g., iterators, views, zero-cost abstractions, SIMD hints if relevant)

Keep the same inputs, outputs, side effects, and observable behavior. Do not change the API, error handling, or correctness. Favor clarity only when it doesn’t hurt performance, and add brief comments if a non-obvious optimization is used.

Now, start by understanding what I’m trying to build and ask any clarifying questions before suggesting the faster code.
