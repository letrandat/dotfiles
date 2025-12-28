# Change: Refine Design to Spec Workflow

## Why

The `dat-design-to-spec` workflow needs to be a lightweight wrapper that delegates strictly to the standard `/openspec-proposal` workflow. Its sole purpose is to bridge the "Design" phase to the "Proposal" phase (Scaffold -> Verify -> Refine) using a design document or context as input. Implementation is explicitly out of scope and handled by `dat-spec-to-tasks`.

## What Changes

- Update `.agent/workflows/dat-design-to-spec.md` to:
  1.  Receive input (Design Doc or Context).
  2.  Invoke the `/openspec-proposal` workflow with that input.
  3.  Prompt the user to refine the specs (add scenarios/criteria).
  4.  Stop after the "Refine" phase (once validation passes).
- Explicitly state that implementation happens later via `dat-spec-to-tasks`.

## Impact

- Affected specs: `workflows`
- Affected code: `.agent/workflows/dat-design-to-spec.md`
