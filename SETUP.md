# Setup Guide for codewizard-26 Profile

Everything here lives in your special profile repository named **`codewizard-26`**
(`github.com/codewizard-26/codewizard-26`).

---

## 1. Local Preview & Generation

All local SVG assets (portrait, skill radar, stat cards, repo cards) can be generated locally and previewed in `preview.html`:

```powershell
# Generate portrait from Frame 1.png
python scripts/dotify.py "assets/Frame 1.png" -o assets/portrait --cols 100 --equalize --detail 0.5 --color --reveal

# Generate skill radar
python scripts/radar.py --data assets/skills.json -o assets/radar

# Generate language radar
python scripts/radar.py --github codewizard-26 -o assets/radar-langs --values --curve 0.4

# Generate stat cards & repo cards
python scripts/cards.py --user codewizard-26 --projects assets/projects.json --out assets
```

Open `preview.html` in your browser to inspect everything before pushing.

---

## 2. Push to GitHub

```bash
git add -A
git commit -m "feat: setup automated dynamic profile"
git push origin main
```

> **Note**: The repo must be **public** so that GitHub can render the SVGs.

---

## 3. Configure GitHub Actions Permissions

1. Go to repository **Settings** → **Actions** → **General**.
2. Under **Workflow permissions**, select **Read and write permissions**.
3. Click **Save**.

---

## 4. Add the `METRICS_TOKEN` Secret

1. Visit [GitHub Tokens](https://github.com/settings/tokens) → **Generate new token (classic)**.
2. Select scopes: **`read:user`** (and **`repo`** if you want private repository contributions counted).
3. Copy the generated token.
4. In your repository: **Settings** → **Secrets and variables** → **Actions** → **New repository secret**.
5. Name it **`METRICS_TOKEN`** and paste the token.

---

## 5. Trigger the Workflows

Under the **Actions** tab in your repository, run:
- **Metrics**: Generates isometric 3D contribution graph, habits, and languages into `assets/`.
- **Snake**: Generates contribution snake animation into the `output` branch.
- **Charts and cards**: Refreshes stats, repo stars, and radar charts.
