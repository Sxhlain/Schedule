#!/bin/bash

# 🚀 Auto Deploy Script untuk Sxhlain/Schedule
# Usage: bash deploy.sh

echo "🚀 Starting deployment to Sxhlain/Schedule..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Repository info
REPO_URL="https://github.com/Sxhlain/Schedule.git"
REPO_DIR="Schedule"
FILE_TO_UPDATE="index.html"

echo -e "${BLUE}📋 Repository: Sxhlain/Schedule${NC}"
echo -e "${BLUE}📄 File: index.html${NC}"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed. Please install git first.${NC}"
    exit 1
fi

# Check if index.html exists in current directory
if [ ! -f "$FILE_TO_UPDATE" ]; then
    echo -e "${RED}❌ index.html not found in current directory.${NC}"
    echo -e "${YELLOW}💡 Make sure you're in the directory containing the updated index.html${NC}"
    exit 1
fi

echo -e "${YELLOW}📥 Cloning repository...${NC}"

# Remove existing directory if it exists
if [ -d "$REPO_DIR" ]; then
    echo -e "${YELLOW}🗑️ Removing existing directory...${NC}"
    rm -rf "$REPO_DIR"
fi

# Clone the repository
if git clone "$REPO_URL"; then
    echo -e "${GREEN}✅ Repository cloned successfully!${NC}"
else
    echo -e "${RED}❌ Failed to clone repository. Check your internet connection.${NC}"
    exit 1
fi

# Enter repository directory
cd "$REPO_DIR" || exit 1

echo -e "${YELLOW}📝 Copying updated file...${NC}"

# Copy the updated file
cp "../$FILE_TO_UPDATE" .

echo -e "${YELLOW}➕ Adding changes to git...${NC}"

# Add changes
git add "$FILE_TO_UPDATE"

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo -e "${YELLOW}⚠️ No changes detected. File might be the same.${NC}"
    cd ..
    rm -rf "$REPO_DIR"
    exit 0
fi

echo -e "${YELLOW}💾 Committing changes...${NC}"

# Commit changes
git commit -m "✨ Major UI/UX update with glassmorphism design and friends system

- Modern glassmorphism design throughout the app
- Instagram-like profile with photo interactions
- Friends system with profile sharing
- Enhanced mobile responsive design
- Smooth animations for schedule navigation
- Modern login modal and photo detail modal
- Like/comment system for posts
- PWA optimizations for mobile devices"

echo -e "${YELLOW}🚀 Pushing to GitHub...${NC}"

# Push changes
if git push origin main; then
    echo ""
    echo -e "${GREEN}🎉 SUCCESS! Deployment completed!${NC}"
    echo ""
    echo -e "${BLUE}🔗 Repository: https://github.com/Sxhlain/Schedule${NC}"
    echo -e "${BLUE}🌐 Live App: https://sxhlain.github.io/Schedule${NC}"
    echo ""
    echo -e "${GREEN}✅ Features deployed:${NC}"
    echo -e "${GREEN}  • Modern glassmorphism UI${NC}"
    echo -e "${GREEN}  • Instagram-like profile${NC}"
    echo -e "${GREEN}  • Friends system${NC}"
    echo -e "${GREEN}  • Mobile responsive design${NC}"
    echo -e "${GREEN}  • Smooth animations${NC}"
    echo -e "${GREEN}  • PWA optimizations${NC}"
    echo ""
else
    echo -e "${RED}❌ Failed to push to GitHub.${NC}"
    echo -e "${YELLOW}💡 You might need to authenticate with GitHub first.${NC}"
    echo -e "${YELLOW}   Try: git config --global user.name 'Your Name'${NC}"
    echo -e "${YELLOW}   Try: git config --global user.email 'your.email@example.com'${NC}"
    exit 1
fi

# Cleanup
cd ..
rm -rf "$REPO_DIR"

echo -e "${GREEN}✨ Deployment completed successfully!${NC}"