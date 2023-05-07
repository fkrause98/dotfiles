{pkgs}:
{
    enable = true;
    # interactiveShellInit = builtins.readFile ./fish/config.fish;
    plugins = with pkgs.fishPlugins; [
      {
        name = "z";
        src = z.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "fzf";
        src = fzf.src;
      }
      {
        name = "tide";
        src = tide.src;
      }
      {
        name = "done";
        src = done.src;
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
    ];
}
