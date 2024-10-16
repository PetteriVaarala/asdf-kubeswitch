#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/danielfoehrKn/kubeswitch"
TOOL_NAME="kubeswitch"
TOOL_TEST="switcher --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

function get_os {
	case "$(uname -s)" in
	Darwin*) echo "darwin" ;;
	Linux*) echo "linux" ;;
	*)
		echo "Unsupported OS"
		exit 1
		;;
	esac
}
os=$(get_os)

function get_arch {
	case "$(uname -m)" in
	aarch64 | arm64) echo "arm64" ;;
	x86_64) echo "amd64" ;;
	*)
		echo "Unsupported architecture"
		exit 1
		;;
	esac
}
arch=$(get_arch)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	# https://github.com/danielfoehrKn/kubeswitch/releases/download/0.9.1/switcher_linux_amd64
	url="$GH_REPO/releases/download/${version}/switcher_${os}_${arch}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "${install_path}/${tool_cmd}"
		chmod +x "${install_path}/${tool_cmd}"

		# Assert kubeswitch executable exists.
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/${tool_cmd} to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
