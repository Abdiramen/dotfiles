{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    dashboard.enable = lib.mkEnableOption "enable glance dashboard";
  };
  config = lib.mkIf config.dashboard.enable {
    services.glance.enable = true;
    services.glance.settings = {
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "calendar";
                  first-day-of-week = "sunday";
                }
                {
                  type = "rss";
                  limit = 10;
                  cache = "12h";
                  feeds = [
                    {
                      url = "https://www.gridbugs.org/rss.xml";
                      title = "gridbugs";
                    }
                    {
                      url = "https://www.joshwcomeau.com/rss.xml";
                      title = "Josh Comeau's blog";
                    }
                    {
                      url = "https://www.mitchellhanberg.com/feed.xml";
                      title = "Mitchell Hanberg blocg";
                    }
                    {
                      url = "https://blog.freecad.org/feed/";
                      title = "FreeCAD Blog";
                    }
                    {
                      url = "https://www.zombiezen.com/blog/index.xml";
                      title = "Roxy's blog";
                    }
                  ];
                }
                {
                  type = "bookmarks";
                  groups = [
                    {
                      links = [
                        {
                          title = "Dropout";
                          url = "https://watch.dropout.tv/browse";
                        }
                        {
                          title = "Gmail";
                          url = "https://mail.google.com/mail/u/0/";
                        }
                        {
                          title = "Wikipedia";
                          url = "https://en.wikipedia.org/";
                        }
                        {
                          title = "GitHub";
                          url = "https://github.com/";
                        }
                      ];
                    }
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      title = "wezterm";
                      type = "repository";
                      repository = "wezterm/wezterm";
                    }
                    {
                      title = "glance";
                      type = "repository";
                      repository = "glanceapp/glance";
                    }
                    {
                      title = "Krita";
                      type = "repository";
                      repository = "KDE/krita";
                    }
                    {
                      title = "Godot";
                      type = "repository";
                      repository = "godotengine/godot";
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      type = "videos";
                      title = "smosh";
                      channels = [
                        "UCY30JRSgfhYXA6i6xX1erWg"
                        "UCYJPby9DRCteedh5tfxVbrw"
                        "UCEyodonqP_80YrDvattntmw"
                        "UCJ2ZDzMRgSrxmwphstrm8Ww"
                        "UCPJHQ5_DLtxZ1gzBvZE99_g"
                      ];
                    }
                    {
                      type = "videos";
                      title = "youtube";
                      channels = [
                        "UCVwfqPkv08OTuHzkPU3EaDw" # Languagejones
                        "UCXGR70CkW_pXb8n52LzCCRw" # Mythical Kitchen
                        "UC-_AkLn4A5iBr6BXN6waR_Q"
                        "UCcaTUtGzOiS4cqrgtcsHYWg"
                        "UC9JS-PJocOPW5YD-Cg9K93Q" # daph
                        "UCDq5v10l4wkV5-ZBIJJFbzQ" # Ethan Chlebowski
                        "UCrk2bNxxxLP-Qd77KxBJ3Xg" # diinki
                        "UC2kEuLCRUrWAvHlupobn4aw" # WatchWesWork (cnc and stuff)
                        "UC_mmaVYaFmlfdxuKb6U69Yw" # Speeed (Cars. Life. Technology)
                      ];
                    }
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "reddit";
                      subreddit = "technology";
                      show-thumbnails = true;
                    }
                    {
                      type = "reddit";
                      subreddit = "selfhosted";
                      show-thumbnails = true;
                    }
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "weather";
                  location = "St. Louis, Missouri, United States";
                  hour-format = "24h";
                }
                {
                  type = "markets";
                  markets = [
                    {
                      symbol = "SPY";
                      name = "S&P 500";
                    }
                    {
                      symbol = "NET";
                      name = "Cloudflare";
                    }
                  ];
                }
                {
                  type = "to-do";
                }
              ];
            }
          ];
        }
        {
          name = "News";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "24h";
                  timezones = [
                    {
                      timezone = "America/Chicago";
                      label = "local";
                    }
                    {
                      timezone = "America/New_York";
                      label = "New York";
                    }
                    {
                      timezone = "Europe/London";
                      label = "London";
                    }
                    {
                      timezone = "Europe/Paris";
                      label = "Paris";
                    }
                    {
                      timezone = "Asia/Tokyo";
                      label = "Tokyo";
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      title = "npr-rss";
                      type = "rss";
                      limit = 20;
                      cache = "12h";
                      feeds = [
                        {
                          url = "https://feeds.npr.org/1001/rss.xml";
                          title = "NPR";
                        }
                      ];
                    }
                    {
                      title = "ft-rss";
                      type = "rss";
                      limit = 20;
                      cache = "12h";
                      feeds = [
                        {
                          url = "https://www.ft.com/news-feed?format=rss";
                          title = "Financial Times";
                        }
                      ];
                    }
                    {
                      title = "dsa-rss";
                      type = "rss";
                      limit = 20;
                      cache = "12h";
                      feeds = [
                        {
                          url = "https://feed.dsausa.org/global/rss20.xml";
                          title = "DSA Feed";
                        }
                        {
                          url = "https://bsky.app/profile/did:plc:zeiqtb6yhtmyyziz27zuxy73/rss";
                          title = "STLDSA - bsky";
                        }
                      ];
                    }
                  ];
                }
              ];
            }
          ];
        }
        {
          name = "AI Bubble trackor";
          columns = [
            {
              size = "full";
              widgets = [
                {
                  type = "markets";
                  markets = [
                    {
                      symbol = "nvda";
                      name = "Nvidia";
                    }
                    {
                      symbol = "qcom";
                      name = "Qualcomm";
                    }
                    {
                      symbol = "mu";
                      name = "Micron Technology";
                    }
                    {
                      symbol = "avgo";
                      name = "Broadcom";
                    }
                    {
                      symbol = "amd";
                      name = "AMD";
                    }
                  ];
                }
                {
                  type = "videos";
                  channels = [
                    "UCsdzuPs5NKvdsBkQnP7Af8w" # Better Offline, Ed Zitron
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
