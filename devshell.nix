{pkgs}:
with pkgs; let
  # android-studio is not available in aarch64-darwin
  conditionalPackages =
    if pkgs.system != "aarch64-darwin"
    then []
    else [];
in
  with pkgs;
  # Configure your development environment.
  #
  # Documentation: https://github.com/numtide/devshell
  # ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/avdmanager create avd -n Pixel_3a_API_35 -k "system-images;android-35;google_apis;x86_64" -d "pixel_3"
    devshell.mkShell {
      name = "react-native-course";
      motd = ''
        Entered the development environment for react-native-course
      '';
      env = [
        {
          name = "ANDROID_HOME";
          value = "${android-sdk}/share/android-sdk";
        }
        {
          name = "ANDROID_SDK_ROOT";
          value = "${android-sdk}/share/android-sdk";
        }
        {
          name = "JAVA_HOME";
          value = jdk.home;
        }
      ];
      packages =
        [
          pkgs.nodejs
          android-sdk
          gradle
          jdk
        ]
        ++ conditionalPackages;
    }
