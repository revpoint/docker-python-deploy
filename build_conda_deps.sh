
RECIPE_DIR=.recipes

rm -rf $RECIPE_DIR

conda skeleton pypi --output-dir $RECIPE_DIR klein
conda build $RECIPE_DIR/klein

# conda skeleton pypi --output-dir $RECIPE_DIR characteristic =14.0
# conda build --build-only $RECIPE_DIR/characteristic
#
# conda skeleton pypi --output-dir $RECIPE_DIR pyasn1
# conda build --build-only $RECIPE_DIR/pyasn1
#
# conda skeleton pypi --output-dir $RECIPE_DIR pyasn1-modules
# conda build --build-only $RECIPE_DIR/pyasn1-modules
#
# conda skeleton pypi --output-dir $RECIPE_DIR service_identity
# conda build --build-only $RECIPE_DIR/service_identity
