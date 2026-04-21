#!/bin/bash
echo "🚀 Starting development workflow..."

echo "📥 Pulling latest code from GitHub..."
git pull origin main

echo ""
echo "========================================="
echo "📄 Handover Document (handover.md):"
echo "========================================="
if [ -f handover.md ]; then
    cat handover.md
else
    echo "(No handover.md found. An empty one will be created.)"
    touch handover.md
fi
echo "========================================="
echo ""
echo "💡 Suggested Next Actions:"
echo "1. Review the handover notes above to see what the previous session left off."
echo "2. Describe what you want to build or run '/opsx-apply' to work on an existing change."
echo "3. Start coding! When you are done, run 'npm run dev:ending' to wrap up."
