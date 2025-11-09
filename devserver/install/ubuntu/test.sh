for file in "imwheel"; do
  stow --verbose --target="$HOME" --dir="devserver" --restow "$file"
done
