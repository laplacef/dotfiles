# dotfiles

My shell and git configuration plus the scripts used to provision a fresh Ubuntu (24.04 LTS) machine.

1. Run the following commands on a fresh machine:

```bash
sudo apt update && sudo apt install -y git
git clone https://github.com/laplacef/dotfiles.git ~/dotfiles
cd ~/dotfiles
./scripts/bootstrap.sh
./scripts/install-extrepo.sh
./install.sh
```

2. Fill in your identity in `~/.gitconfig-personal`.

> [!NOTE]
> Each script is safe to re-run. `install.sh` asks before touching any existing file.

## License

[MIT](LICENSE)
