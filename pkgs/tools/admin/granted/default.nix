{ buildGoModule, fetchFromGitHub, lib, makeWrapper, xdg-utils }:

let
  pname = "granted";
  version = "0.14.2";
  owner = "common-fate";
in
buildGoModule rec {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "common-fate";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-BxtEMIWJaZaCtd5auGRq+F3VkRTZXGBa6GdLWgvC+ZE=";
  };

  vendorSha256 = "sha256-tPWdzPJyjxcjDM5UgIeQek60Df/7dSaKedZF04tfu6Q=";

  ldflags = ''-X "github.com/${owner}/${pname}/internal/build.Version=${version}"'';

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/granted \
      --suffix PATH : ${lib.makeBinPath [ xdg-utils ]}
  '';

  meta = with lib; {
    homepage = "https://github.com/common-fate/granted";
    description = "The easiest way to access your cloud.";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ ymatsiuk ];
    mainProgram = "granted";
  };
}
