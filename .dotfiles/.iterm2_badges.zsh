# https://medium.com/@adrian_cooney/iterm-tip-add-custom-badges-on-a-per-directory-basis-1d54dfc6b6e4
# shell integration should be installed https://iterm2.com/documentation-shell-integration.html
# \(user.badge)
function iterm2_print_user_vars() {
  iterm2_set_user_var badge $(basename `dirs`)
}

