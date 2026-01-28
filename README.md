# Introduction

This `README` file contains information on the contents of the `meta-watermelon-wine-stm32mp` layer.

`meta-watermelon-wine-stm32mp` exist for the Watermelon Wine boards designed by [DanielMartensson](https://github.com/DanielMartensson),
specifically the Watermelon Wine boards based on stm32 microcontrollers.

# Supported machines

 * [watermelon-wine-1a](https://github.com/DanielMartensson/Watermelon-Wine-1A)

# Planed support

 * [STM32-Computer](https://github.com/DanielMartensson/STM32-Computer)

# Dependencies

## stm-st-stm32mp-mx

URI: https://github.com/STMicroelectronics/meta-st-stm32mp-addons.git
branch: scarthgap

# Quick start

See [yocto-watermelon-wine-stm32mp](https://github.com/evildeeds/yocto-watermelon-wine-stm32mp)

# Setup

## Clone

This git repository uses a lightweight approach with git submodules to reference external devicetree repositories which is
because how `meta-st-stm32-addons` (aka `stm-st-stm32mp-mx`) is inteded to be used by including `CubeMX` projects within a meta-layer,
see [How_to_compile_the_device_tree_with_the_Distribution_Package](https://wiki.st.com/stm32mpu/wiki/How_to_compile_the_device_tree_with_the_Distribution_Package) for details;
a consideration is switching to [repo](https://gerrit.googlesource.com/git-repo) to make external change processes easier to manage,
but for now it will be git submodules.

`git clone --recurse-submodules https://github.com/evildeeds/meta-watermelon-wine-stm32mp.git`

or if you already cloned but forgot to recurse submodules

`git submodule update --init --recursive`

## Adding the custom layer to your build

`bitbake-layers add-layer meta-watermelon-wine-stm32mp`
