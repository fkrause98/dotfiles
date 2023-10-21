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
       src = pkgs.fetchFromGitHub {
         owner = "PatrickF1";
         repo = "fzf";
         rev = "f9e2e48a54199fe7c6c846556a12003e75ab798e";
         sha256 = "UP+bk5luk6bNrMzI4eQkt9TzU8dkjEqGoEnlEh4fEK4=";
       };
     }

    # Ingnoring tide until I get an answer here:
    # https://github.com/IlanCosman/tide/issues/457
    # {
    #   name = "tide";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "IlanCosman";
    #     repo = "tide";
    #     rev = "96635fbfd3448ca2a7bead773537e91e86913614";
    #     sha256 = "WA+4JOcbQncy52iSe7Tp4KeFbrQKV+5nFJYRoQbfsvs=";
    #   };
    # }

    {
      name = "done";
      inherit (done) src;
    }

    {
      name = "fish-git-abbr";
      src = pkgs.fetchFromGitHub {
        owner = "lewisacidic";
        repo = "fish-git-abbr";
        rev = "abe95203b7fcb1eaa685bd5b75796b52bb7be884";
        sha256 = "UP+bk5luk6bNrMzI4eQkt9TzU8dkjEqGoEnlEh4fEK4=";
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
