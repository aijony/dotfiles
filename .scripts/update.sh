sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

stackage-update

npm update -g

sudo pacman -Syu

yaourt -Syu

yaourt -Syu --aur --noconfirm
