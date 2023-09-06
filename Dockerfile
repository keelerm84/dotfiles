FROM archlinux

ENV SHELL /usr/bin/zsh

RUN echo "[multilib]" >> /etc/pacman.conf && \
    echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
    sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$(nproc)\"/" /etc/makepkg.conf

# Install packages required for building
RUN pacman --noconfirm -Syu binutils curl gcc git fakeroot gmp make neovim sudo tmux unzip zsh

RUN curl -Lo tree-sitter.gz https://github.com/tree-sitter/tree-sitter/releases/download/v0.20.8/tree-sitter-linux-x64.gz && \
        gunzip tree-sitter.gz && \
        chmod +x tree-sitter && \
        mv tree-sitter /usr/local/bin/

RUN groupadd --gid 1000 archbtw && \
    useradd --create-home --system --shell /usr/sbin/zsh --uid 1000 --gid 1000 archbtw && \
    passwd -d archbtw && \
    echo 'archbtw ALL=(ALL) ALL' > /etc/sudoers.d/archbtw && \
    chsh -s /bin/zsh archbtw

USER archbtw
WORKDIR /home/archbtw

RUN git clone --depth 1 https://aur.archlinux.org/yay.git /tmp/yay && \
    cd /tmp/yay && \
    makepkg --noconfirm -si && \
    yay --afterclean --removemake --save && \
    rm -rf /tmp/yay

# Install languages specific packages
RUN yay --noconfirm -Sy composer ghcup-hs-bin go npm php ruby

# Install dotfiles
RUN git clone https://github.com/andsens/homeshick.git ~/.homesick/repos/homeshick
COPY --chown=archbtw:archbtw . .homesick/repos/dotfiles

RUN ~/.homesick/repos/homeshick/bin/homeshick link -b
