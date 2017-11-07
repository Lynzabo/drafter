#!/bin/bash
#
# ./upload-to-github-releases.sh 'Lynzabo/harbor' 1.0.0 your_token 描述内容 'harbor-offline-installer-v1.2.0-mi-rc5.tgz'
# 申请github token:https://github.com/settings/tokens/new	YOUR_TOKEN
#
# 获取指定repo的tag的release列表
# curl -H "Authorization: token YOUR_TOKEN" "https://api.github.com/repos/Lynzabo/harbor/releases/tags/v1.2.0-mi-rc4"

# # 使用release_id号删除这个release
# curl -X 'DELETE' -H "Authorization: token YOUR_TOKEN" "https://api.github.com/repos/Lynzabo/harbor/releases/${old_release_id}")
# # 创建release
# curl -H "Authorization: token YOUR_TOKEN" -H 'Content-Type: application/json' --data "{ \"tag_name\": \"v1.2.0-mi-rc6\", \"name\": \"v1.2.0-mi-rc6\", \"body\": \"描述内容\"}" "https://api.github.com/repos/Lynzabo/harbor/releases"
# {
#   "url": "https://api.github.com/repos/Lynzabo/harbor/releases/8355633",
#   "assets_url": "https://api.github.com/repos/Lynzabo/harbor/releases/8355633/assets",
#   "upload_url": "https://uploads.github.com/repos/Lynzabo/harbor/releases/8355633/assets{?name,label}",
#   "html_url": "https://github.com/Lynzabo/harbor/releases/tag/v1.2.0-mi-rc6",
#   "id": 8355633,
#   "tag_name": "v1.2.0-mi-rc6",
#   "target_commitish": "master",
#   "name": "v1.2.0-mi-rc6",
#   "draft": false,
#   "author": {
#     "login": "Lynzabo",
#     "id": 9922971,
#     "avatar_url": "https://avatars0.githubusercontent.com/u/9922971?v=4",
#     "gravatar_id": "",
#     "url": "https://api.github.com/users/Lynzabo",
#     "html_url": "https://github.com/Lynzabo",
#     "followers_url": "https://api.github.com/users/Lynzabo/followers",
#     "following_url": "https://api.github.com/users/Lynzabo/following{/other_user}",
#     "gists_url": "https://api.github.com/users/Lynzabo/gists{/gist_id}",
#     "starred_url": "https://api.github.com/users/Lynzabo/starred{/owner}{/repo}",
#     "subscriptions_url": "https://api.github.com/users/Lynzabo/subscriptions",
#     "organizations_url": "https://api.github.com/users/Lynzabo/orgs",
#     "repos_url": "https://api.github.com/users/Lynzabo/repos",
#     "events_url": "https://api.github.com/users/Lynzabo/events{/privacy}",
#     "received_events_url": "https://api.github.com/users/Lynzabo/received_events",
#     "type": "User",
#     "site_admin": false
#   },
#   "prerelease": false,
#   "created_at": "2017-11-02T08:12:57Z",
#   "published_at": "2017-11-02T09:49:42Z",
#   "assets": [

#   ],
#   "tarball_url": "https://api.github.com/repos/Lynzabo/harbor/tarball/v1.2.0-mi-rc6",
#   "zipball_url": "https://api.github.com/repos/Lynzabo/harbor/zipball/v1.2.0-mi-rc6",
#   "body": "描述内容"
# }
# # 上传文件
# curl -H "Authorization: token YOUR_TOKEN" -H "Content-Type: $(file -b --mime-type "harbor-offline-installer-v1.2.0-mi-rc5.tgz")" --data-binary "@harbor-offline-installer-v1.2.0-mi-rc5.tgz" "${upload_url}?name=https://uploads.github.com/repos/Lynzabo/harbor/releases/8355633/assets?name=harbor-offline-installer-v1.2.0-mi-rc5.tgz"


#!/bin/bash
#
# 申请github token:https://github.com/settings/tokens/new	1${TOKEN}
#
# 直接替换这几个参数为实际参数，下面命令都已经是OK的
TOKEN="1714465b218ddec173eaa4ae6bff685a7095c759d"
REPO_NAME="Lynzabo/harbor"
TAG_NAME="v1.2.0-mi-rc6"
DESCRIPTION=""
FILENAME="harbor-offline-installer-v1.2.0-mi-rc6.tgz"

# 获取指定repo的tag的release列表
# curl -H "Authorization: token ${TOKEN}" "https://api.github.com/repos/${REPO_NAME}/releases/tags/${TAG_NAME}"

# 使用release_id号删除这个release
# curl -X 'DELETE' -H "Authorization: token ${TOKEN}" "https://api.github.com/repos/${REPO_NAME}/releases/${old_release_id}")
# 创建release
response=`curl -H "Authorization: token ${TOKEN}" -H 'Content-Type: application/json' --data "{ \"tag_name\": \"${TAG_NAME}\", \"name\": \"${TAG_NAME}\", \"body\": \"${DESCRIPTION}\"}" "https://api.github.com/repos/${REPO_NAME}/releases"`
echo ${response}

upload_url="$(echo "${response}" | jq -r '.upload_url' | sed 's/{?name,label}$//g')"
echo ${upload_url}

# 上传文件
curl -H "Authorization: token ${TOKEN}" -H "Content-Type: $(file -b --mime-type "${FILENAME}")" --data-binary "@${FILENAME}" "${upload_url}?name=${FILENAME}" | jq