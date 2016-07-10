# Description

ansible-doc generates snippets for Sublime Text auto completion

## Requirements

- Sublime Text 2/3+
- gnu-sed
- ansible
- OSX

## Installation

```shell
# Clone the repo
$ git clone https://github.com/lxhunter/ansible-sublime-text-snippets.git

# Move into the directory
$ cd ansible-sublime-text-snippets

# Create the directory which holds the snippets
$ mkdir ~/Library/Application Support/Sublime Text 3/Packages/ansible-sublime-text-snippets

# Optional: install gnu-sed
$ brew install gnu-sed

# Optional: install ansible
$ brew install ansible

# Optional: make the generator executable
$ chmod 0755 ansible-doc-to-sublime-snippet.sh

# Execute the generator
$ ./ansible-doc-to-sublime-snippet.sh
```

## Uninstallation

```shell
$ rm -r ~/Library/Application Support/Sublime Text 3/Packages/ansible-sublime-text-snippets
```

## Examples

1. Create a .yaml file in Sublime or use the supplied test.yml
2. write ```apt``` and hit tab to witness auto completion 
3. Enjoy!

## Todos

* Use native sed, to requirements 
* Use different plugin folder to make it os agnostic
* Package it for plugin Manager
* My war with search and replace could be less ugly (suggestion welcome)

## Quote

"Nothing will work unless you do." 
- Maya Angelou

## Credits

* [Initial Idea by João Paulo Seregatte](https://github.com/seregatte/AnsibleSnippets)
* Found typos by Dominik Pötzschke

## Contribute

[Tutorial](http://kbroman.github.io/github_tutorial/pages/fork.html)

## Author

Author:: [Alexander Jäger](https://github.com/lxhunter)

Copyright 2016
