{ inputs
, pkgs
, ...
}: {
  # themable spotify
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
    in
    {
      enable = true;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
      enabledCustomApps = with spicePkgs.apps; [ lyrics-plus new-releases ];
      theme = spicePkgs.themes.text;
      colorScheme = "spotify";
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        shuffle
        adblock
        playlistIcons
        lastfm
        historyShortcut
        bookmark
        fullAlbumDate
        groupSession
        popupLyrics
      ];
    };
}
