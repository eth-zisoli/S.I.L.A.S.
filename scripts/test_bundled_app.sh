#!/bin/bash
# Test script to build and run the bundled macOS app locally

set -e

echo "🔨 Building Silas Desktop App with PyInstaller..."
echo ""

# Get to project root
cd "$(dirname "$0")/.." || exit

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build dist
echo ""

# Build with PyInstaller
echo "📦 Building app bundle..."
python -m PyInstaller silas_desktop.spec
echo ""

# Check if build succeeded
if [ -d "dist/Silas.app" ]; then
    echo "✅ Build successful!"
    echo ""
    echo "📍 App location: $(pwd)/dist/Silas.app"
    echo ""

    # Show app contents for debugging
    echo "📂 App structure:"
    ls -lh dist/Silas.app/Contents/MacOS/
    echo ""

    # Make the app executable
    chmod +x dist/Silas.app/Contents/MacOS/Silas

    # Run the app in terminal to see output
    echo "🚀 Launching app (console mode enabled for debugging)..."
    echo "   This should open a Terminal window showing the app's output"
    echo "   If successful, you'll see the Silas icon in the menu bar"
    echo ""

    open -a Terminal dist/Silas.app

    echo ""
    echo "📝 If the app crashes or fails:"
    echo "   1. Check the Terminal window that opened for error messages"
    echo "   2. Check ~/Library/Logs/silas_desktop_crash.log"
    echo "   3. Run manually: ./dist/Silas.app/Contents/MacOS/Silas"
    echo ""
else
    echo "❌ Build failed! Check the output above for errors."
    exit 1
fi

