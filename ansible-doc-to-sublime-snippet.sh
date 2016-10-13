#!/bin/bash

# Reset
color_off='\033[0m'       # Text Reset

# Regular Colors
black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

target_path="$HOME/Library/Application Support/Sublime Text 3/Packages/ansible-sublime-text-snippets"

if [ ! -d "$target_path" ]; then
    echo -e >&2 "${red} Target Directory is missing: $target_path${color_off}"
    exit 1
fi

command -v gsed >/dev/null || { echo -e >&2 "${red}I need gsed, brew install coreutils${color_off}"; exit 2; }
command -v ansible-doc >/dev/null || { echo -e >&2 "${red}I need ansible-doc, brew install ansible${color_off}"; exit 3; }

if [ "$1" != "" ]; then
  modules=( "$1" )
else
  modules=$( ansible-doc -l | cut -d' ' -f1 )
fi

for module in $modules; do

  if [ "$module" = "DEPRECATED:" ]; then
      echo "Deprecated modules will be left out!"
      exit 0
  fi

  echo -e -n "Generating snippet for ${yellow}'$module'${color_off} module: "

  snippet_content=`ansible-doc -s $module | gsed -e "s/\s\{31\}/FOO/g" | gsed ':a;N;$!ba;s/\n/BAR/g' | gsed -e 's/BARFOO//g' | gsed -e 's/BAR/\n/g' | gsed -e 's/action: \(.*\)/\1:/g' | gsed -e 's/name: \(.*\)/name: \${1:\1}/g' | gsed -e "s/^\s\{6\}\([0-9a-z_]\{1,\}\)=\{,1\}\s\{1,\}#\(.*\)/    # \1: \2/g"`   

  if [ "$snippet_content" = "" ]; then
    echo -e "${red} failed! ${color_off}"
    continue
  fi

    echo "<snippet>
  <content>
    <![CDATA[$snippet_content]]>
  </content>
  <tabTrigger>$module</tabTrigger>
  <scope>source.yaml,source.ansible</scope>
</snippet>" > "$target_path/$module.sublime-snippet"

echo -e "${green} done ${color_off}"

done

for snippet in snippets/*; do
  echo -e -n "Copy custom snippet $snippet: "
  cp "$snippet" "$target_path"
  echo -e "${green} done ${color_off}"
done
