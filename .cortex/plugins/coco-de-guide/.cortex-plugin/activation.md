# coco-de-guide

This plugin bundles three things for the dbt project in this repository:

- **Skill `new-dbt-model`** – the team's conventions and workflow for adding a dbt model.
- **Hook `validate-bash`** – blocks any `dbt` command that targets production (`--target prod`).
- **Subagent `dbt-review`** – reviews changed dbt models against the conventions and reports PASS/FAIL.
