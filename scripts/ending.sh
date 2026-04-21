#!/bin/bash
echo "🏁 Wrapping up development workflow..."

echo "✅ Step 1: Update tasks.md"
echo "Please make sure you have checked off your progress in tasks.md."
read -p "Press Enter to continue once you've verified the tasks..."

echo ""
echo "📦 Step 2: Archive the OpenSpec change (optional)"
read -p "Did you complete an OpenSpec change that needs archiving? [y/N] " should_archive
if [[ "$should_archive" =~ ^[Yy]$ ]]; then
    read -p "Enter the change folder name exactly (e.g. c01-integrate-aiot-final-project): " change_name
    npx @fission-ai/openspec archive "$change_name"
else
    echo "Skipping archive."
fi

echo ""
echo "📝 Step 3: Write Handover Document"
echo "Please take a moment to update 'handover.md' with notes and next steps for the next development session."
read -p "Press Enter after you finish editing handover.md..."

echo ""
echo "🚀 Step 4: Push code to GitHub"
git add .
git commit -m "chore: dev wrapup and handover updates"
git push origin main

echo "🎉 Development wrap-up complete!"
