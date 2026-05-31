#!/bin/bash

read -rp "Clone GMS? [Y/n]: " gms_choice

case "${gms_choice,,}" in
    y|yes|"")
        echo "Cloning GMS..."
        git clone https://github.com/RedLintu16/gms vendor/gms
        if [ $? -ne 0 ]; then
            echo "WARNING: GMS clone failed (already exists or network issue). Continuing anyway."
        fi
        echo "GMS cloned successfully."
        sed -i 's|#$(call inherit-product, vendor/gms/gms.mk)|$(call inherit-product, vendor/gms/gms.mk)|' device/oneplus/infiniti/lineage_infiniti.mk
        echo "Uncommented GMS inherit in lineage_infiniti.mk."
        ;;
    n|no)
        echo "Skipping GMS clone."
        sed -i 's|^$(call inherit-product, vendor/gms/gms.mk)|#$(call inherit-product, vendor/gms/gms.mk)|' device/oneplus/infiniti/lineage_infiniti.mk
        echo "GMS inherit left commented in lineage_infiniti.mk."
        ;;
    *)
        echo "Invalid input, skipping GMS clone."
        ;;
esac

# Continue with other stuff

rm -rf prebuilts/misc/protobuf_vendorcompat

lunch lineage_infiniti-bp4a-userdebug