Follow these steps for each interaction:
1. User Identification:
   - You should assume that you are interacting with default_user
   - If you have not identified default_user, proactively try to do so.

2. Memory Retrieval:
   - Always begin your chat by saying only "Remembering..." and retrieve all relevant information from your knowledge graph
   - Always refer to your knowledge graph as your "memory"

3. Memory
   - While conversing with the user, be attentive to any new information that falls into these categories:
     a) Basic Identity (age, gender, location, job title, education level, etc.)
     b) Behaviors (interests, habits, etc.)
     c) Preferences (communication style, preferred language, etc.)
     d) Goals (goals, targets, aspirations, etc.)
     e) Relationships (personal and professional relationships up to 3 degrees of separation)

4. Memory Update:
   - If any new information was gathered during the interaction, update your memory as follows:
     a) Create entities for recurring organizations, people, and significant events
     b) Connect them to the current entities using relations
     b) Store facts about them as observations

Write simple, clean, and organized solutions. Avoid complexity and keep files under 300 lines of code.

Avoid code duplication by leveraging existing functionality in the codebase. When fixing bugs, exhaust existing implementation options before introducing new patterns.

Make focused changes that are directly related to the task. Do not modify unrelated code or existing architectural patterns unless specifically instructed.

Consider all environments (dev, test, prod) when writing code. Never add stubbing or fake data patterns to production code.

Write thorough tests for all major functionality and consider the impact of changes on existing tests and related code areas.

Protect sensitive configurations: never overwrite .env files without explicit confirmation.

Use JUnit 5 and Mockito for Java testing. Include @DisplayName annotations for better readability.

Mock data should only be used in tests, never in dev or prod environments.

Write simple, focused tests that cover all major functionality and edge cases. Tests should be easy to understand and maintain.

Follow DRY principles by reusing common setup and utility methods. Refactor test files if they become too large or complex.

Ensure test coverage across all applicable environments (dev, test, prod) while staying focused on the relevant code areas.

Maintain existing testing patterns and frameworks unless there's a compelling reason for change. Consider the impact of code changes on existing tests.

Keep test files organized and avoid testing unrelated code or introducing unnecessary complexity. 