" Description: adds chef support to ctrlp's funky extension
" Language: Chef
" Author: Takahiro YOSHIHARA
" License: The MIT License

" docs.opscode.com/resource.html
let resources = [
      \ 'apt_package',
      \ 'chef_gem',
      \ 'cookbook_file',
      \ 'cron',
      \ 'deploy',
      \ 'directory',
      \ 'dpkg_package',
      \ 'easy_install_package',
      \ 'env',
      \ 'erl_call',
      \ 'execute',
      \ 'file',
      \ 'freebsd_package',
      \ 'gem_package',
      \ 'git',
      \ 'group',
      \ 'http_request',
      \ 'ifconfig',
      \ 'ips_package',
      \ 'link',
      \ 'log',
      \ 'macports_package',
      \ 'mdadm',
      \ 'mount',
      \ 'ohai',
      \ 'package',
      \ 'pacman_package',
      \ 'portage_package',
      \ 'powershell_script',
      \ 'remote_directory',
      \ 'remote_file',
      \ 'rpm_package',
      \ 'route',
      \ 'ruby_block',
      \ 'scm',
      \ 'script',
      \ 'service',
      \ 'smartos_package',
      \ 'solaris_package',
      \ 'subversion',
      \ 'template',
      \ 'user',
      \ 'yum_package'
\ ]

let s:filter = [{ 'pattern': '\m\C^[\t ]*\('.join(resources, '\|').'\)[\t ]\+\S\+',
                \ 'filter': ['\m\C^[\t ]*', '', 'g']}]

function! ctrlp#funky#chef#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#chef#get_filter()
  return s:filter
endfunction

