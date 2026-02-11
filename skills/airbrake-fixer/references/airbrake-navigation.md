# Airbrake UI Navigation Guide

Reference for navigating Airbrake's web interface using Chrome browser automation tools.

## Page Structure

### Groups List Page (`/projects/{id}/groups`)

The main error listing page shows error groups. Each row contains:

- **Environment badge** — colored label (e.g., "pr", "production", "st")
- **Occurrence count** — number with icon (e.g., "2.2k", "248", "22")
- **Severity** — typically "error"
- **GitHub icon** — small Octocat icon that links to a GitHub issue (if linked)
- **Sparkline graph** — small occurrence trend chart
- **Timestamp** — relative time (e.g., "16 hours ago")
- **Error description** — error class and message below the badges

### Reading the Error List

Use `get_page_text` to extract the full text content of the groups list page. The errors are listed in rows. Parse each row to extract:

1. The error class and message text
2. The occurrence count number
3. The environment label
4. The timestamp

If `get_page_text` doesn't give structured enough data, use `read_page` with a specific area or take a screenshot and read the visual content.

### Filtering

Airbrake has filter controls at the top of the groups page:

- **Status filter** — "Status: unresolved" chip/tag near the top. Click the "x" to remove or click to change.
- **Search box** — text search for error messages
- **Sort controls** — buttons/icons to change sort order
- **Environment filter** — may appear as a dropdown or chip filter

To filter by production only:
1. Look for any existing environment filter chips
2. If not filtered, look for a filter/search area and type or select "production"
3. Take a screenshot to confirm the filter is applied

### Pagination

The page shows "1-20 of N" with arrow navigation. The errors are pre-sorted by most recent by default. To get highest-occurrence errors, look for a sort control or parse all visible errors and sort locally.

## Error Detail Page

### Overview Tab (default)

Shows summary of the error group:
- Error class and full message at the top
- Occurrence count and time range
- Tabs: **Overview**, **Occurrences**, **Aggregations**, **Comments**

### Occurrences Tab

Click the "Occurrences" tab (shows count badge like "22"). This reveals:
- **View Occurrence List** link at top
- Individual occurrence details with expandable sections

Each occurrence shows:
- **Occurrence ID** at the top
- Expandable sections (click "+" to expand, "x" to collapse):
  - **Details** — Full error message, URL, component (controller#action)
  - **Backtrace** — Stack trace with file paths and line numbers. Application code lines are highlighted differently from framework/gem lines.
  - **Parameters** — Request parameters as JSON (controller, action, id, etc.)
  - **Environment** — Server environment info (program_name, etc.)
  - **Session** — User session data if available

### Extracting Backtrace

The backtrace section is the most critical. It shows:
```
app/controllers/some_controller.rb:42 in `some_method`
app/models/some_model.rb:15 in `another_method`
```

Focus on lines starting with `app/` — these are application code. Lines from gems, Rails framework, or Ruby stdlib can be ignored for fix purposes.

### GitHub Issue Link

The GitHub icon appears on the error group page (in the error row) and sometimes on the detail page. It's a small GitHub Octocat icon. Clicking it opens the linked GitHub issue.

To find the GitHub link:
1. On the error group row, look for the GitHub icon after the severity badge
2. Click the icon — it may open a new tab with the GitHub issue
3. Alternatively, use `read_page` to find `href` attributes containing `github.com`

If the GitHub icon is not present or not linked, no GitHub issue exists for this error.

## Tips for Browser Automation

- **Take screenshots frequently** — Airbrake's UI is dynamic and may change; screenshots help you see the current state
- **Use `get_page_text`** for bulk text extraction — faster than reading individual elements
- **Expand sections by clicking** — Backtrace, Parameters, etc. are collapsed by default
- **Wait for page loads** — After clicking a tab or error, the content loads asynchronously; take a screenshot to verify content is loaded before reading
- **Handle pagination** — The top 5 errors by occurrence should be visible on the first page if sorted correctly
