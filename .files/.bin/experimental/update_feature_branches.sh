#!/bin/bash

# Función para manejar cambios no comprometidos
handle_uncommitted_changes() {
    local branch="$1"

    # Verificar si hay cambios no comprometidos
    if [[ -n $(git status --porcelain) ]]; then
        echo "Hay cambios no comprometidos en la rama $branch."
        read -p "¿Deseas comprometerlos (c) o almacenarlos temporalmente (s)? " choice

        case "$choice" in
            c|C)
                git add .
                read -p "Introduce el mensaje del commit: " commit_message
                git commit -m "$commit_message"
                ;;
            s|S)
                git stash
                ;;
            *)
                echo "Opción no válida. Saliendo del script."
                exit 1
                ;;
        esac
    fi
}

# Actualizar la rama develop
git checkout develop
git pull origin develop

# Verificar las ramas feature locales
feature_branches=$(git branch --list 'feature/*')

# Actualizar cada rama feature
for branch in $feature_branches; do
    echo "Actualizando rama: $branch"
    git checkout "$branch"
    handle_uncommitted_changes "$branch"
    git merge develop
done

# Subir las ramas feature actualizadas
for branch in $feature_branches; do
    echo "Subiendo rama: $branch"
    git checkout "$branch"
    git push origin "$branch"
done

# Volver a la rama original
git checkout -
