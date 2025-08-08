#!/bin/bash

echo "🚀 Snipe-IT Railway Setup Script"
echo "================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: Git is not installed${NC}"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "Dockerfile.railway" ]; then
    echo -e "${RED}Error: Please run this script from the SnipeAPP directory${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 1: Initializing Git repository...${NC}"
git init

echo -e "${YELLOW}Step 2: Adding remote repository...${NC}"
git remote remove origin 2>/dev/null
git remote add origin https://github.com/danilapryadko/snipe-it-railway.git

echo -e "${YELLOW}Step 3: Copying Snipe-IT source files...${NC}"
if [ -d "snipe-it" ]; then
    echo "Snipe-IT repository already exists"
else
    echo "Cloning Snipe-IT repository..."
    git clone https://github.com/snipe/snipe-it.git
fi

echo -e "${YELLOW}Step 4: Creating necessary directories...${NC}"
mkdir -p storage/app/backups
mkdir -p storage/framework/{sessions,views,cache}
mkdir -p storage/logs
mkdir -p public/uploads

echo -e "${YELLOW}Step 5: Setting up Git...${NC}"
git add .
git commit -m "Initial Snipe-IT setup for Railway deployment"

echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo "Next steps:"
echo "1. Push to GitHub:"
echo "   ${GREEN}git push -u origin main${NC}"
echo ""
echo "2. If you get an error about the branch, try:"
echo "   ${GREEN}git branch -M main${NC}"
echo "   ${GREEN}git push -u origin main${NC}"
echo ""
echo "3. Go to Railway.app and follow the deployment guide"
echo ""
echo "📖 See RAILWAY_DEPLOYMENT_GUIDE.md for detailed instructions"
echo ""
echo -e "${YELLOW}Generate your APP_KEY with:${NC}"
echo "php -r \"echo 'base64:' . base64_encode(random_bytes(32)) . PHP_EOL;\""