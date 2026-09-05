.PHONY: update switch test debug upp history repl gc gc-sudo gcboot clean

update:
	nix flake update ~/nixos-config

switch:
	sudo nixos-rebuild switch --flake ~/nixos-config#nixos

test:
	sudo nixos-rebuild test --flake ~/nixos-config#nixos

debug:
	sudo nixos-rebuild switch --flake ~/nixos-config#nixos --show-trace --verbose

upp:
	nix flake update ~/nixos-config/$(i)

history:
	nix profile history --profile /nix/var/nix/profiles/system

repl:
	nix repl -f flake:nixpkgs
	
gc:
	nix-collect-garbage

gc-sudo:
	sudo nix-collect-garbage

gcboot:
	sudo /run/current-system/bin/switch-to-configuration boot

clean:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d