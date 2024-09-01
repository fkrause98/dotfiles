{ pkgs }: {
  enable = true;
  interactiveShellInit = builtins.readFile ../fish/config.fish;
  plugins = with pkgs.fishPlugins; [
    {
      name = "z";
      inherit (z) src;
    }
    {
      name = "colored-man-pages";
      inherit (colored-man-pages) src;
    }
    {
      name = "autopair";
      inherit (autopair) src;
    }

    {
      name = "fzf";
      inherit (fzf) src;
    }

    {
      name = "tide";
      inherit (tide) src;
    }

    {
      name = "done";
      inherit (done) src;
    }

    {
      name = "fish-git-abbr";
      src = pkgs.fetchFromGitHub {
        owner = "lewisacidic";
        repo = "fish-git-abbr";
        rev = "dc590a5b9d9d2095f95f7d90608b48e55bea0b0e";
        sha256 = "6z3Wr2t8CP85xVEp6UCYaM2KC9PX4MDyx19f/wjHkb0=";
      };
    }
    {
      name = "fish-abbreviation-tips";
      src = pkgs.fetchFromGitHub {
        owner = "gazorby";
        repo = "fish-abbreviation-tips";
        rev = "8ed76a62bb044ba4ad8e3e6832640178880df485";
        sha256 = "F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
      };
    }
    {
      name = "fisher";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "fisher";
        rev = "67bec738dbec2442d05d09ef72b2be82acb1d774";
        sha256 = "rtWPiEalxUhZQMZ8Ydk3E4wKke+Pdl7WaM4iOEKYuvM=";
      };
    }
    {
      name = "replay";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "replay.fish";
        rev = "bd8e5b89ec78313538e747f0292fcaf631e87bd2";
        sha256 = "bM6+oAd/HXaVgpJMut8bwqO54Le33hwO9qet9paK1kY=";
      };
    }
    {
      name = "fish-asdf";
      src = pkgs.fetchFromGitHub {
        owner = "rstacruz";
        repo = "fish-asdf";
        rev = "5869c1b1ecfba63f461abd8f98cb21faf337d004";
        sha256 = "sha256-39L6UDslgIEymFsQY8klV/aluU971twRUymzRL17+6c";
      };
    }
  ];
}
