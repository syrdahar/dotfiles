#!/bin/bash

symlink() {
    if [ $# -lt 2 ]; then
        echo "Usage: symlink <source1> [source2] [...] <destination>"
        return 1
    fi
    
    local args=("$@")
    local num_args=$#
    
    local destination="${args[$((num_args-1))]}"
    
    local sources=("${args[@]:0:$((num_args-1))}")
    
    if [ ! -e "$destination" ]; then
        echo "Error: Destination '$destination' does not exist."
        return 1
    fi
    
    local dest_is_dir=false
    if [ -d "$destination" ]; then
        dest_is_dir=true
    fi
    
    if [ ${#sources[@]} -gt 1 ] && [ "$dest_is_dir" = false ]; then
        echo "Error: Multiple sources provided but destination is not a directory."
        return 1
    fi
    
    local linked=0
    local failed=0
    
    for source in "${sources[@]}"; do
        if [ ! -e "$source" ]; then
            echo "✗ Source '$source' does not exist, skipping..."
            ((failed++))
            continue
        fi
        
        local target_path
        if [ "$dest_is_dir" = true ]; then
            local basename=$(basename "$source")
            target_path="$destination/$basename"
        else
            target_path="$destination"
        fi
        
        local abs_source=$(realpath "$source")
        
        if [ -e "$target_path" ] || [ -L "$target_path" ]; then
            echo "⚠ Target '$target_path' already exists, skipping..."
            continue
        fi
        
        if ln -s "$abs_source" "$target_path"; then
            echo "✓ Linked: $target_path -> $abs_source"
            ((linked++))
        else
            echo "✗ Failed to link: $source"
            ((failed++))
        fi
    done
    
    echo
    echo "Linking summary:"
    echo "- Successfully linked: $linked"
    echo "- Failed: $failed"
    
    if [ "$failed" -gt 0 ]; then
        return 1
    fi
}

###########################

symlink ".bashrc" ".clang-format" ".ideavimrc" ".xinitrc" ".Xresources" ".zshrc" "$HOME"
symlink "chadwm" "st" "$HOME/sources"
symlink "nvim" "$HOME/.config"
