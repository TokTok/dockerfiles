FROM toxchat/nix:latest

WORKDIR /root
COPY ghc.nix /root
RUN ["nix-build", "ghc.nix"]
RUN ["nix-shell", "-p", "qt5.qtbase.dev", "qt5.qtmultimedia.dev", "qt5.qttools.dev", "qt5.qtsvg.dev", "--run", "moc --version"]
RUN ["nix-shell", "-p", "go", "--run", "go version"]
