#!/usr/bin/env bash

set -eux
project_dir="$(pwd)"
# Something broke in version 1.8.11. It exits with error:
# wrong number of arguments (given 1, expected 2)

#if [[ ! ${trigger_cookiecutter} && ! ${setup_travis} ]];then
#    exit 0
#fi

if [[ ${setup_travis} = true ]]; then
    gem install travis -v 1.8.10
    travis version --no-interactive
    travis login --no-interactive --github-token "$(jq .TF_VAR_github_token -r .env/tf_env.json)" --com
fi


workdir="$(mktemp -d)"

# shellcheck disable=SC2154
export GIT_SSH_COMMAND="ssh -i ${ssh_key_path} -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

cd "$workdir"

if [[ ${trigger_cookiecutter} = true ]]; then
    # shellcheck disable=SC2154
    echo "Generating ${repo_kind} repo"

    case "${repo_kind}" in
       "terraform")
          cookiecutter_url="https://github.com/revenants-cie/cookiecutter-terraform.git"
          ;;
       "python")
          cookiecutter_url="https://github.com/audreyr/cookiecutter-pypackage.git"
          ;;
       "empty")
          cookiecutter_url="https://github.com/revenants-cie/cookiecutter-empty.git"
          ;;
       *)
         echo "Unsupported repo kind ${repo_kind}"
         exit 1
         ;;
    esac

    # shellcheck disable=SC2154
    cat << EOF > cookiecutter.yaml
    default_context:
        full_name: "${organization}"
        project_name: "${project_name}"
        project_slug: "{{ cookiecutter.project_name.lower().replace(' ', '_').replace('-', '_') }}"
        project_short_description: "${project_short_description}"
        states_bucket: "${states_bucket}"
        email: "${email}"
        github_username: "${github_username}"
        pypi_username: "{{ cookiecutter.github_username }}"
        version: "0.1.0"
        use_pytest: "y"
        use_pypi_deployment_with_travis: "n"
        add_pyup_badge: "n"
        command_line_interface: "Click"
        create_author_file: "n"
        open_source_license: "Not open source"

EOF
    # shellcheck disable=SC2154
    cookiecutter --config-file cookiecutter.yaml --no-input "$cookiecutter_url"
    project_slug=$(echo "${project_name}" | tr "[:upper:]" "[:lower:]" | sed -e 's/ /_/g' -e 's/-/_/g')
    cd "$project_slug"
    git init
    git add .
    git commit -m "first commit"
fi

# shellcheck disable=SC2154
git remote add origin git@github.com:"${organization}"/"${repo_name}".git
# shellcheck disable=SC2154
git push -u origin "${default_branch}"

if [[ ${setup_travis} = true ]]; then
    # Configure secrets with travis
    travis enable --no-interactive --repo "${organization}/${repo_name}" --com
    cp -R "$project_dir/.env" .
    tar cf .env.tar .env
    travis encrypt-file .env.tar --no-interactive --add --repo "${organization}/${repo_name}"
    rm -rf .env.tar .env

    git add .env.tar.enc
    git add .travis.yml
    git commit -m "Add secrets file"
    git push -u origin "${default_branch}"
fi

rm -rf "$workdir"
