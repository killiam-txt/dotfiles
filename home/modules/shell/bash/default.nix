{
  programs.bash = {
    enable = false;
    enableCompletion = false;
    bashrcExtra = ''
         export PATH="$PATH:$HOME/bin"
      alias cls=clear
      alias nv=nvim
    '';
  };
}
