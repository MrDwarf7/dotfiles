#!/usr/bin/env fish
#
# if $WIN_AVAILABLE = true; then
#     # rust / cargo related
#     alias cbw='cargo build --target x86_64-pc-windows-gnu'
#     alias cbrw='cargo build --release --target x86_64-pc-windows-gnu'
#     alias crw='cargo run --target x86_64-pc-windows-gnu'
#     alias crqw='cargo run -q --target x86_64-pc-windows-gnu'
#     alias crrw='cargo run --release --target x86_64-pc-windows-gnu'
#     alias cbaw='cargo build --target x86_64-pc-windows-gnu && cargo build --release --target x86_64-pc-windows-gnu'
#
#     alias cba='cargo build --target x86_64-pc-windows-gnu && cargo build --target x86_64-unknown-linux-gnu'
#     alias cbra='cargo build --release --target x86_64-pc-windows-gnu && cargo build --release --target x86_64-unknown-linux-gnu'
#     alias cble='cba && cbra && cb && cbr'
#     # vs code
#     # alias code=launch_code_wsl
#     return
# end

alias cb 'cargo build'
alias cbr 'cargo build --release'

alias cr 'cargo run'
alias crq 'cargo run -q'
alias crr 'cargo run --release'
alias ct 'cargo test'
alias cch 'cargo check'
alias ccl 'cargo clean'
alias cu 'cargo update'
alias cdoc 'cargo doc'
alias cup 'cargo upgrade'

alias ct 'cargo test'
alias ctq 'cargo test --quiet'

alias cta 'cargo test --all'
alias ctaq 'cargo test --all --quiet'

alias cw 'cargo watch'
alias cwq 'cargo watch -q'
alias cwqc 'cargo watch -q -c'
alias cwqcr 'cargo watch -q -c -x run'
