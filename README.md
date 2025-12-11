# dotfiles
My personal development environment configuration

For automatic installation with your project deployment you need to have a devcontainer setup.
i.e.
```
mkdir -p .devcontainer
cat > .devcontainer/devcontainer.json << 'EOF'
{
  "name": "GH900",
  "postCreateCommand": "bash ~/dotfiles/install.sh"
}
EOF
```

For manual installation, run the following command in your terminal:

```bash
bash ~/dotfiles/install.sh 
```
when the codespace launches