#!/usr/bin/env bash

set -ex

echo "Install Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install gocan..."
brew install fouadh/tap/gocan

echo "Run the tests..."

if [[ -z "${GOCAN}" ]]; then
  GOCAN="gocan"
fi

$GOCAN --version

$GOCAN start-db

echo "Cleaning up before starting"
$GOCAN delete-scene maat

echo "Creating the scene & the app"
$GOCAN create-scene maat
$GOCAN create-app maat --scene maat

echo "Importing the history"
tmp_dir=$(mktemp -d -t gocan-XXXXXXX)
echo "Cloning maat in $tmp_dir/maat"
git clone https://github.com/adamtornhill/code-maat.git $tmp_dir/maat

cd $tmp_dir/maat
$GOCAN import-history maat --scene maat --before 2013-11-01

echo "Get app summary"
$GOCAN app maat --scene maat

echo "Analyze change frequency"
$GOCAN revisions maat --scene maat | head -n 10

echo "Sum of coupling"
$GOCAN soc maat --scene maat | head -n 10

echo "Measuring coupling"
$GOCAN coupling maat --scene maat

echo "Create src vs test boundaries"
$GOCAN create-boundary src_test_boundaries --scene maat --app maat --transformation Code:src/code_maat --transformation Test:test/code_maat

echo "Perform architectural analysis on boundaries"
$GOCAN coupling maat --scene maat --boundary src_test_boundaries

echo "Creating more specific test boundaries"
$GOCAN create-boundary src_test_detailed_boundaries --scene maat --app maat \
        --transformation Code:src/code_maat \
        --transformation "Analysis Test:test/code_maat/analysis" \
        --transformation "Dataset Test:test/code_maat/dataset" \
        --transformation "End to end Tests:test/code_maat/end_to_end" \
        --transformation "Parsers Test:test/code_maat/parsers"

echo "Perform architectural analysis on the detailed boundaries"
$GOCAN coupling maat --scene maat --boundary src_test_detailed_boundaries

echo "Analyze the revisions from an architectural level"
$GOCAN revisions maat --scene maat --boundary src_test_boundaries

echo "Create a revisions trends"
$GOCAN create-revisions-trends src_test --scene maat --app maat --boundary src_test_boundaries

echo "Visualize the revisions trends"
$GOCAN revisions-trends src_test --scene maat --app maat

echo "Create software architecture boundaries"
$GOCAN create-boundary pipes_filter_boundaries --scene maat --app maat \
        --transformation Parse:src/code_maat/parsers \
        --transformation Analyze:src/code_maat/analysis \
        --transformation Output:src/code_maat/output \
        --transformation Application:src/code_maat/app

echo "Perform architectural analysis on the pipes filter architecture"
$GOCAN coupling maat --scene maat --boundary pipes_filter_boundaries

echo "Study code churn"
$GOCAN code-churn maat --scene maat

echo "That's All Folks !"