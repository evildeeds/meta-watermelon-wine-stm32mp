SRC_URI += " \
    file://clk-stm32-core.c \
    file://clk-stm32mp2.c \
    file://stm32mp2_ram.c \
"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

EXTRA_OEMAKE += "${@bb.utils.contains('ST_TF_A_DEBUG_TRACE', '1', 'STM32MP_EARLY_CONSOLE=1', '', d)}"

EXTRA_OEMAKE += "LOG_LEVEL=40"

do_sed_patch() {
    sed -i \
      -e 's|/\* USART2 on HSI@64MHz, TX on GPIOA4 Alternate 6 \*/|/* USART6 on HSI@64MHz, TX on PF13 Alternate 3 */|' \
      -e 's|#define STM32MP_DEBUG_USART_BASE\s*USART2_BASE|#define STM32MP_DEBUG_USART_BASE                USART6_BASE|' \
      -e 's|#define DEBUG_UART_TX_GPIO_BANK_ADDRESS\s*GPIOA_BASE|#define DEBUG_UART_TX_GPIO_BANK_ADDRESS         GPIOF_BASE|' \
      -e 's|#define DEBUG_UART_TX_GPIO_BANK_CLK_REG\s*RCC_GPIOACFGR|#define DEBUG_UART_TX_GPIO_BANK_CLK_REG         RCC_GPIOFCFGR|' \
      -e 's|#define DEBUG_UART_TX_GPIO_BANK_CLK_EN\s*RCC_GPIOxCFGR_GPIOxEN|#define DEBUG_UART_TX_GPIO_BANK_CLK_EN          RCC_GPIOxCFGR_GPIOxEN|' \
      -e 's|#define DEBUG_UART_TX_GPIO_PORT\s*4|#define DEBUG_UART_TX_GPIO_PORT                 13|' \
      -e 's|#define DEBUG_UART_TX_GPIO_ALTERNATE\s*6|#define DEBUG_UART_TX_GPIO_ALTERNATE            3|' \
      -e 's|#define DEBUG_UART_TX_CLKSRC_REG\s*RCC_XBAR8CFGR|#define DEBUG_UART_TX_CLKSRC_REG                RCC_XBAR8CFGR|' \
      -e 's|#define DEBUG_UART_TX_CLKSRC\s*XBAR_SRC_HSI|#define DEBUG_UART_TX_CLKSRC                    XBAR_SRC_HSI|' \
      -e 's|#define DEBUG_UART_TX_EN_REG\s*RCC_USART2CFGR|#define DEBUG_UART_TX_EN_REG                    RCC_USART6CFGR|' \
      -e 's|#define DEBUG_UART_TX_EN\s*RCC_UARTxCFGR_UARTxEN|#define DEBUG_UART_TX_EN                        RCC_UARTxCFGR_UARTxEN|' \
      -e 's|#define DEBUG_UART_RST_REG\s*RCC_USART2CFGR|#define DEBUG_UART_RST_REG                      RCC_USART6CFGR|' \
      -e 's|#define DEBUG_UART_RST_BIT\s*RCC_UARTxCFGR_UARTxRST|#define DEBUG_UART_RST_BIT                      RCC_UARTxCFGR_UARTxRST|' \
      -e 's|#define DEBUG_UART_PREDIV_CFGR\s*RCC_PREDIV8CFGR|#define DEBUG_UART_PREDIV_CFGR                  RCC_PREDIV8CFGR|' \
      -e 's|#define DEBUG_UART_FINDIV_CFGR\s*RCC_FINDIV8CFGR|#define DEBUG_UART_FINDIV_CFGR                  RCC_FINDIV8CFGR|' \
      ${S}/plat/st/stm32mp2/stm32mp2_def.h

      mv ${S}/drivers/st/clk/clk-stm32-core.c ${S}/drivers/st/clk/clk-stm32-core.c.bak
      cp ${WORKDIR}/clk-stm32-core.c ${S}/drivers/st/clk/clk-stm32-core.c
      mv ${S}/drivers/st/clk/clk-stm32mp2.c ${S}/drivers/st/clk/clk-stm32mp2.c.bak
      cp ${WORKDIR}/clk-stm32mp2.c ${S}/drivers/st/clk/clk-stm32mp2.c
      mv ${S}/drivers/st/ddr/stm32mp2_ram.c ${S}/drivers/st/ddr/stm32mp2_ram.c.bak
      cp ${WORKDIR}/stm32mp2_ram.c ${S}/drivers/st/ddr/stm32mp2_ram.c
}
addtask do_sed_patch after do_patch before do_configure
