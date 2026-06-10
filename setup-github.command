#!/bin/bash
set -e

SKILLS_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_NAME="skills"
GITHUB_USER="geofftrembley"

echo "=== Skills → GitHub ==="
echo "Directory: $SKILLS_DIR"
echo ""

cd "$SKILLS_DIR"

# Init git if needed
if [ ! -d ".git" ]; then
  echo "Initializing git..."
  git init
  git branch -M main
fi

# Stage and commit
echo "Staging files..."
git add .

if git diff --cached --quiet; then
  echo "Nothing new to commit."
else
  git commit -m "Initial commit: AI assistant skills for thinking, writing, and operations"
  echo "Committed."
fi

# Create repo and push
if command -v gh &> /dev/null; then
  echo ""
  echo "Creating GitHub repo via gh CLI..."
  gh repo create "$GITHUB_USER/$REPO_NAME" \
    --public \
    --description "AI assistant skills for thinking, writing, and operations" \
    --source=. \
    --remote=origin \
    --push
  echo ""
  echo "Done! Repo live at: https://github.com/$GITHUB_USER/$REPO_NAME"
else
  echo ""
  echo "gh CLI not found. Adding remote manually..."
  git remote remove origin 2>/dev/null || true
  git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
  echo ""
  echo "Next steps:"
  echo "  1. Create the repo at https://github.com/new (name: $REPO_NAME, public)"
  echo "  2. Then run: git -C '$SKILLS_DIR' push -u origin main"
fi

echo ""
read -p "Press Enter to close..."
