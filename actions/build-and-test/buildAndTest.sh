
function contains() {
    if [[ $1 == *"$2"* ]]; then return 1; else return ; fi;
}

#if: ${{ contains(inputs.include-steps, "check-types") }}

echo "Setting up npm..."
npm config set registry https://registry.npmjs.org

echo "Installing dependencies..."
npm ci

if contains "$include_steps" "check-types"; then
  echo "Checking types..."
  npm run check-types
fi

if contains "$include_steps" "lint"; then
  echo "Linting repository..."
  npm run lint:ci
fi

if contains "$include_steps" "build"; then
  echo "Building..."
  npm run build
  rm -rf .git
  rm -rf node_modules/.cache
fi

if contains "$include_steps" "test"; then
  echo "Testing..."
  npm run test:ci
  echo "Build checks successfull"
fi